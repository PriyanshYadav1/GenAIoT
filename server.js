const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const port = 3000;


app.use(bodyParser.json());
app.use(cors());


const apps = [
  { name: "Bulldozer", imageUrl: "https://cdn.pixabay.com/photo/2017/04/02/09/08/bulldozer-2195329_1280.jpg" },
  { name: "Police Car Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png" },
  { name: "Home Security Monitoring", imageUrl: "https://cdn.pixabay.com/photo/2013/07/13/12/12/camera-159400_640.png" },
 
];

const allAssets = [
  { title: 'Police Car Monitoring System 1', icon: 'local_police', status: 'connected' },
  { title: 'Police Car Monitoring System 2', icon: 'local_police', status: 'disconnected' },
  { title: 'Police Car Monitoring System 3', icon: 'local_police', status: 'off' },
  { title: 'Bulldozer Asset 1', icon: 'directions_railway', status: 'connected' },
  { title: 'Bulldozer Asset 2', icon: 'directions_railway', status: 'disconnected' },
  
];

const user = {
    "username": "UserName",
    "email": "username@gmail.com",
    "image": "https://cdn.pixabay.com/photo/2015/12/22/04/00/photo-1103597_640.png"
  };

  const drawerItems = [
    {"title": "Home", "icon": "home"},
    {"title": "Apps", "icon": "apps"},
    {"title": "My Profile", "icon": "person"},
    {"title": "Sites", "icon": "cloud"},
    {"title": "Tickets", "icon": "confirmation_number"}
  ]


app.get('/apps', (req, res) => {
  res.json(apps);
});


app.get('/user', (req, res) => {
    res.json(user);
  });

  app.get('/draweritems', (req, res) => {
    res.json(drawerItems);
  });

app.get('/assets/:appName', (req, res) => {
  const appName = req.params.appName.toLowerCase();
  const filteredAssets = allAssets.filter(asset => asset.title.toLowerCase().includes(appName));
  res.json(filteredAssets);
});


app.listen(port,'0.0.0.0', () => {
  console.log(`Server running at http://localhost:${port}`);
});
