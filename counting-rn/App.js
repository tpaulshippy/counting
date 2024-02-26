import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import CountersList from './components/CountersList';
import Login from './Login';
import { useEffect, useState } from 'react';
import { getCookie } from './client';

export default function App() {
  const [view, setView] = useState('login');
  const showCounters = () => {
    setView('counters');
  };
  useEffect(() => {
    const cookie = getCookie();
    if (cookie !== '') {
      showCounters();
    }
    else {
      setView('login');
    }
  });
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Counters</Text>
      <StatusBar style="auto" />
      {view === 'counters' ? <CountersList /> : <Login onLogin={showCounters} />}
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
