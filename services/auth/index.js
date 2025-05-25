﻿const express = require('express');
const app = express();
const port = process.env.PORT || 4000;

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'auth' });
});

app.listen(port, () => {
  console.log(`Auth service listening on port ${port}`);
});
