const express = require('express');
const app = express();
const port = process.env.PORT || 4002;

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'diagnostics' });
});

app.listen(port, () => {
  console.log(`Diagnostics service listening on port ${port}`);
});
