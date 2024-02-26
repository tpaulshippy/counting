import { useEffect, useState } from 'react';
import { Button, RefreshControl, ScrollView, StyleSheet, Text, View } from 'react-native';
import { fetchData, openSocket, setCookie, setStream } from '../client';
import { Dimensions } from "react-native";
const windowWidth = Dimensions.get('window').width;

export default function CountersList() {
    const [counters, setCounters] = useState([]);
    const [refreshing, setRefreshing] = useState(false);

    const onRefresh = async () => {
        setRefreshing(true);
        const response = await fetchData("/counters.json", "GET");
        const data = await response.json();
        console.log("Data returned from refresh", data);
        setCounters(data);
        setRefreshing(false);
        refreshStream();
    };

    const refreshStream = () => {
        openSocket((event) => {
            const data = JSON.parse(event.data);
            
            if (data.message && typeof data.message == 'string') {
                let json = data.message.substring(data.message.indexOf("<template>")+10);
                json = json.substring(0, json.indexOf("</template>"));
                json = json.replace(/&quot;/g, '"');
                json = JSON.parse(json);

                console.log("Data returned from stream", json);
                if (counters.length === 0) {
                    console.error("No counters to update");
                    return;
                }
                const newCounters = counters.map((counter) => {
                    if (counter.id === json.id) {
                        counter.number = json.number;
                    }
                    return counter;
                });
                setCounters(newCounters);
            }
        });
    }

    useEffect(() => {
        async function init() {
            const response = await fetchData("/counters.json", "GET");
            if (response.error)
                console.error(response.error);
            else {
                const data = await response.json();
                console.log("Data returned from init", data);
                if (data.error) {
                    console.error(data.error);
                    setCookie(null);
                    setStream(null);
                }
                setCounters(data);
                refreshStream();
            }
            
        }
        init();
    }, []);

    const pressButton = (id, button) => {
        fetchData(`/counters/${id}.json`, "PUT",
        {
            "commit": button
        }).then((response) => {;
            console.log(response);
        });
    }

    return (
        <ScrollView
            contentContainerStyle={styles.scrollViewContent}
            refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
        >
            {counters.map ? counters.map((counter) => (
                <View style={styles.counterContainer} key={counter.id}>
                    <Text style={styles.name}>{counter.name}</Text>
                    <Text style={styles.number}>{counter.number}</Text>

                    <View style={styles.buttonContainer}>
                        <Button title="Up" onPress={() => pressButton(counter.id, "Up")} />
                        <Button title="Down" onPress={() => pressButton(counter.id, "Down")} />
                        <Button title="Reset" onPress={() => pressButton(counter.id, "Reset")} />
                    </View>
                </View>
            )) : null}
        </ScrollView>
    );
}

const styles = StyleSheet.create({
    counterContainer: {
        flex: 1,
        flexDirection: 'column',
        justifyContent: 'space-between',
        alignItems: 'left',
        padding: 20,
        borderBottomWidth: 1,
        borderBottomColor: '#ccc',
        width: windowWidth,
    },
    buttonContainer: {
        flexDirection: 'row',
    },
    name: {
      fontSize: 24,
      fontWeight: 'bold',
      color: '#fff',
    },
    number: {
      fontSize: 48,
      color: '#fff',
    },
  });
  