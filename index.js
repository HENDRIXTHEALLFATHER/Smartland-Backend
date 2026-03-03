import express from "express";
import userRoutes from "./src/routes/users.js";
import landRoutes from "./src/routes/lands.js";

const app = express();

app.use(express.json()); // IMPORTANT
app.use("/api/users", userRoutes);
app.use("/api/lands", landRoutes);

app.get("/", (req, res) => {
  res.send("SmartLand API running");
});

const PORT = 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📍 http://localhost:${PORT}`);
  console.log(`👥 Users API: http://localhost:${PORT}/api/users`);
  console.log(`🏞️  Lands API: http://localhost:${PORT}/api/lands`);
});