import { useEffect, useState } from 'react';
import { Button, RefreshControl, ScrollView, StyleSheet, Text, View } from 'react-native';
import { fetchData } from '../client';
import { Dimensions } from "react-native";
const windowWidth = Dimensions.get('window').width;

export default function CountersList() {
    const [counters, setCounters] = useState([]);
    const [refreshing, setRefreshing] = useState(false);

    const onRefresh = async () => {
        setRefreshing(true);
        const data = await fetchData();
        setCounters(data);
        setRefreshing(false);
    };

    useEffect(() => {
        async function init() {
            const data = await fetchData();
            setCounters(data);
        }
        init();
    }, []);

    return (
        <ScrollView
            contentContainerStyle={styles.scrollViewContent}
            refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
        >
            {counters.map((counter) => (
                <View style={styles.counterContainer} key={counter.id}>
                    <Text style={styles.name}>{counter.name}</Text>
                    <Text style={styles.number}>{counter.number}</Text>

                    <View style={styles.buttonContainer}>
                        <Button title="Up" />
                        <Button title="Down" />
                        <Button title="Reset" />
                    </View>
                </View>
            ))}
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
  