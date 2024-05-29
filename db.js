import mysql from "mysql2";

export const connection = mysql.createConnection({
  host: "db",
  user: "root",
  password: "Joss50Joss70",
  database: "db_sia",
  port: "3306",
});

connection.connect((err) => {
  if (err) {
    console.error("Error de conexión:", err);
    return;
  }
  console.log("Conectado a la base de datos MySQL");
});
