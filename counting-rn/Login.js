import { StyleSheet, Text, View, TextInput, Button } from 'react-native';
import React, { useState } from 'react';
import { fetchData, setCookie } from './client';

export default function Login({ onLogin }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = () => {
    fetchData('/sessions/create', 'POST', { login: username, password }).then((response) => {
      if (response.error) {
        console.error(response.error);
      }
      else if (response.status === 200) {
        console.log('Logged in');
        // hold the cookie for future requests
        cookie = response.headers.map['set-cookie'];
        setCookie(cookie);
        onLogin();
      }
      else if (response.status === 401) {
        console.error('Login failed');
      }
    });

  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        placeholder="Username"
        placeholderTextColor={'#aaa'}
        value={username}
        onChangeText={setUsername}
      />
      <TextInput
        style={styles.input}
        placeholder="Password"
        placeholderTextColor={'#aaa'}
        secureTextEntry
        value={password}
        onChangeText={setPassword}
      />
      <Button title="Login" onPress={handleLogin} />
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

    alignItems: 'stretch',
    justifyContent: 'top',
  },
  input: {
    height: 40,
    margin: 12,
    borderWidth: 1,
    color: '#fff',
  },
});
