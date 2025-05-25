const express = require('express');
const app = express();
const port = process.env.PORT || 4001;

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'user' });
});

app.listen(port, () => {
  console.log(`User service listening on port ${port}`);
});
