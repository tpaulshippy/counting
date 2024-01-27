import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import CountersList from './components/CountersList';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Counters</Text>
      <StatusBar style="auto" />
      <CountersList />
    </View>
  );
}

const styles = StyleSheet.create({
  title: {
    fontSize: 48,
    fontWeight: 'bold',
    padding: 20,
    color: '#fff',
  },
  container: {
    flex: 1,
    backgroundColor: '#000',
    alignItems: 'left',
    justifyContent: 'center',    
  },
});
