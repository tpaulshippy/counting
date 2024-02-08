const baseUrl = 'http://192.168.1.176:3000';
let cookie = '';

export const fetchData = (endpoint, method, data) => {
    const headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    };
    if (cookie) {
        headers['Cookie'] = cookie;
    }
    const options = { 
        method: method,
        headers: headers
    };
    if (method === 'POST' || method === 'PUT') {
        options.body = JSON.stringify(data);
    }
    console.log(options)
    return fetch(`${baseUrl}${endpoint}`, options)
        .then(response => response)
        .catch(error => console.error('Error:', error));
};

export const setCookie = (c) => {
    cookie = c;
}

export const getCookie = () => {
    return cookie;
}