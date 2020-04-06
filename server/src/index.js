import express from "express";
import api from "./api";

const app = express();

app.use(api);

app.get("/", express.static("../../client/build"));
app.get("/", (req, res) => {
  res.sendFile("../../client/build/index.html");
});

if (require.main == module) {
  // We are run from cli
  const PORT = process.env.PORT || 8080;
  app.listen(PORT, () => {
    console.log(
      `Started on port: ${PORT}, go to http://localhost:${PORT} to view atlantic.`
    );
    console.log(`App listening to ${PORT}....`);
    console.log("Press Ctrl+C to quit.");
  });
}

export default app; // Export so we can mess with it in out server
