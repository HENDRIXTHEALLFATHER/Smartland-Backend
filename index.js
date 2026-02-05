import express from "express";
import userRoutes from "./routes/users.js";

const app = express();

app.use(express.json()); // IMPORTANT
app.use("/api/users", userRoutes);

app.get("/", (req, res) => {
  res.send("SmartLand API running");
});

const PORT = 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📍 http://localhost:${PORT}`);
  console.log(`👥 Users API: http://localhost:${PORT}/api/users`);
});