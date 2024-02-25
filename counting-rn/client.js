const host = '192.168.1.176:3000';
const baseUrl = `http://${host}`;
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
    console.log(endpoint, options);
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

let stream = '';
export const setStream = (s) => {
    console.log('Setting stream:', s);
    stream = s;
}

export const getStream = () => {
    console.log('Getting stream:', stream);
    return stream;
}

let webSocket;
export const openSocket = (onMessage) => {
    const streamName = getStream();
    if (webSocket) {
        webSocket.close();
    }
    webSocket = new WebSocket(`ws://${host}/cable`, [
        "actioncable-v1-json"
      ]);

      webSocket.onmessage = (event) => {
        onMessage(event);
      };

      webSocket.onopen = (event) => {
        console.log("Connected to server");

        webSocket.send(
          JSON.stringify({
            command: "subscribe",
            identifier: JSON.stringify({
              channel: "Turbo::StreamsChannel",
              signed_stream_name: streamName,
            }),
          })
        );
      };

      webSocket.onclose = (event) => {
        console.log("Disconnected from server");
      };

      webSocket.onerror = (event) => {
        console.error("Error:", event);
      };
}