
export const fetchData = () => {
    return fetch('http://192.168.1.176:3000/counters.json')
        .then(response => response.json())
        .catch(error => console.error('Error:', error));
};