import mysql from "mysql";

export const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "AdminSIA10042024JJLACV",
  database: "db_sia",
});

connection.connect((err) => {
  if (err) {
    console.error("Error de conexión:", err);
    return;
  }
  console.log("Conectado a la base de datos MySQL");
});
