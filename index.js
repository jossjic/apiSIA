import express from "express";
import bodyParser from "body-parser";
import { connection } from "./db.js";
import crypto from "crypto";

const app = express();

// Middleware para permitir solicitudes desde localhost:5173
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "http://localhost:5173");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});

// Middleware para analizar el cuerpo de las solicitudes como JSON
app.use(bodyParser.json());

app.get("/", (req, res) => {
  connection.query("SELECT * FROM Alimento", (err, rows) => {
    if (err) {
      console.error("Error de consulta:", err);
      return res.status(500).send("Error de servidor");
    }
    res.json(rows);
  });
});

// Obtener todos los alimentos
app.get("/alimentos", (req, res) => {
  connection.query("SELECT * FROM Alimento", (err, rows) => {
    if (err) {
      console.error("Error de consulta:", err);
      return res.status(500).send("Error de servidor");
    }
    res.json(rows);
  });
});

// Obtener todos los alimentos unido con tabla marca y unidadmedida.
app.get("/alimentos/join/all", (req, res) => {
  connection.query(
    "SELECT * FROM Alimento LEFT OUTER JOIN Marca ON Alimento.m_id = Marca.m_id NATURAL JOIN UnidadMedida ORDER BY Alimento.a_nombre",
    (err, rows) => {
      if (err) {
        console.error("Error de consulta:", err);
        return res.status(500).send("Error de servidor");
      }
      res.json(rows);
    }
  );
});

// Obtener todos los alimentos unido con tabla marca
app.get("/alimentos/join/marca", (req, res) => {
  connection.query(
    "SELECT * FROM Alimento LEFT OUTER JOIN Marca ON Alimento.m_id = Marca.m_id ORDER BY Alimento.a_nombre",
    (err, rows) => {
      if (err) {
        console.error("Error de consulta:", err);
        return res.status(500).send("Error de servidor");
      }
      res.json(rows);
    }
  );
});

// Obtener un alimento por ID
app.get("/alimentos/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "SELECT * FROM Alimento WHERE a_id = ?",
    [id],
    (err, rows) => {
      if (err) {
        console.error("Error de consulta:", err);
        return res.status(500).send("Error de servidor");
      }
      if (rows.length === 0) {
        return res.status(404).send("Alimento no encontrado");
      }
      res.json(rows[0]);
    }
  );
});

// Agregar un nuevo alimento
app.post("/alimentos", (req, res) => {
  const {
    a_nombre,
    a_cantidad,
    a_stock,
    a_fechaSalida,
    a_fechaEntrada,
    a_fechaCaducidad,
    um_id,
    m_id,
  } = req.body;
  connection.query(
    "INSERT INTO Alimento (a_nombre, a_cantidad, a_stock, a_fechaSalida, a_fechaEntrada, a_fechaCaducidad, um_id, m_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
    [
      a_nombre,
      a_cantidad,
      a_stock,
      a_fechaSalida,
      a_fechaEntrada,
      a_fechaCaducidad,
      um_id,
      m_id,
    ],
    (err, result) => {
      if (err) {
        console.error("Error al insertar alimento:", err);
        return res.status(500).send("Error de servidor");
      }
      res.status(201).send("Alimento agregado correctamente");
    }
  );
});

// Actualizar un alimento por ID
app.put("/alimentos/:id", (req, res) => {
  const { id } = req.params;
  const {
    a_nombre,
    a_cantidad,
    a_stock,
    a_fechaSalida,
    a_fechaEntrada,
    a_fechaCaducidad,
    um_id,
    m_id,
  } = req.body;
  connection.query(
    "UPDATE Alimento SET a_nombre = ?, a_cantidad = ?, a_stock = ?, a_fechaSalida = ?, a_fechaEntrada = ?, a_fechaCaducidad = ?, um_id = ?, m_id = ? WHERE a_id = ?",
    [
      a_nombre,
      a_cantidad,
      a_stock,
      a_fechaSalida,
      a_fechaEntrada,
      a_fechaCaducidad,
      um_id,
      m_id,
      id,
    ],
    (err, result) => {
      if (err) {
        console.error("Error al actualizar alimento:", err);
        return res.status(500).send("Error de servidor");
      }
      res.status(200).send("Alimento actualizado correctamente");
    }
  );
});

// Eliminar un alimento por ID
app.delete("/alimentos/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "DELETE FROM Alimento WHERE a_id = ?",
    [id],
    (err, result) => {
      if (err) {
        console.error("Error al eliminar alimento:", err);
        return res.status(500).send("Error de servidor");
      }
      res.status(200).send("Alimento eliminado correctamente");
    }
  );
});

//-----------------------------------------------------------------------------------------------------------------------

// Obtener todos los usuarios
app.get("/usuarios", (req, res) => {
  connection.query("SELECT * FROM Usuario", (err, rows) => {
    if (err) {
      console.error("Error de consulta:", err);
      return res.status(500).send("Error de servidor");
    }
    res.json(rows);
  });
});

// Obtener un usuario por ID
app.get("/usuarios/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "SELECT * FROM Usuario WHERE u_id = ?",
    [id],
    (err, rows) => {
      if (err) {
        console.error("Error de consulta:", err);
        return res.status(500).send("Error de servidor");
      }
      if (rows.length === 0) {
        return res.status(404).send("Alimento no encontrado");
      }
      res.json(rows[0]);
    }
  );
});

// Agregar un nuevo usuario
app.post("/usuarios", (req, res) => {
  const { u_id, u_nombre, u_apellidos, u_email, u_contraseña } = req.body;

  const hashedContraseña = crypto
    .createHash("sha256")
    .update(u_contraseña)
    .digest("hex");

  connection.query(
    "INSERT INTO Usuario (u_id, u_nombre, u_apellidos, u_email, u_contraseña) VALUES (?, ?, ?, ?, ?)",
    [u_id, u_nombre, u_apellidos, u_email, hashedContraseña],
    (err, result) => {
      if (err) {
        console.error("Error al insertar alimento:", err);
        return res.status(500).send("Error de servidor");
      }
      res.status(201).send("Alimento agregado correctamente");
    }
  );
});
// Actualizar un usuario por ID
app.put("/usuarios/:id", (req, res) => {
  const { id } = req.params;
  const { u_id, u_nombre, u_apellidos, u_email } = req.body;

  // Comprueba si se proporcionó un ID válido en el cuerpo de la solicitud
  if (!u_id) {
    return res
      .status(400)
      .send("Se requiere un ID de usuario válido en el cuerpo de la solicitud");
  }

  // Ejecuta la consulta para actualizar el usuario
  connection.query(
    "UPDATE Usuario SET u_id = ?, u_nombre = ?, u_apellidos = ?, u_email = ? WHERE u_id = ?",
    [u_id, u_nombre, u_apellidos, u_email, id],
    (err, result) => {
      if (err) {
        console.error("Error al actualizar usuario:", err);
        return res.status(500).send("Error de servidor");
      }
      // Comprueba si se actualizó correctamente el usuario
      if (result.affectedRows === 0) {
        return res.status(404).send("Usuario no encontrado");
      }
      res.status(200).send("Usuario actualizado correctamente");
    }
  );
});

// Cambiar la contraseña de un usuario por ID
app.put("/usuarios/:id/contraseña", (req, res) => {
  const { id } = req.params;
  const { nueva_contraseña } = req.body;

  // Verificar si se proporcionó una nueva contraseña válida en el cuerpo de la solicitud
  if (!nueva_contraseña) {
    return res
      .status(400)
      .send(
        "Se requiere una nueva contraseña válida en el cuerpo de la solicitud"
      );
  }

  // Encriptar la nueva contraseña usando SHA-256
  const hashedNuevaContraseña = crypto
    .createHash("sha256")
    .update(nueva_contraseña)
    .digest("hex");

  // Ejecutar la consulta para actualizar la contraseña del usuario
  connection.query(
    "UPDATE Usuario SET u_contraseña = ? WHERE u_id = ?",
    [hashedNuevaContraseña, id],
    (err, result) => {
      if (err) {
        console.error("Error al cambiar la contraseña del usuario:", err);
        return res.status(500).send("Error de servidor");
      }
      // Comprobar si se actualizó correctamente la contraseña del usuario
      if (result.affectedRows === 0) {
        return res.status(404).send("Usuario no encontrado");
      }
      res.status(200).send("Contraseña cambiada correctamente");
    }
  );
});

// Eliminar un usuario por ID
app.delete("/usuarios/:id", (req, res) => {
  const { id } = req.params;

  // Ejecuta la consulta para eliminar el usuario
  connection.query(
    "DELETE FROM Usuario WHERE u_id = ?",
    [id],
    (err, result) => {
      if (err) {
        console.error("Error al eliminar usuario:", err);
        return res.status(500).send("Error de servidor");
      }
      // Comprueba si se eliminó correctamente el usuario
      if (result.affectedRows === 0) {
        return res.status(404).send("Usuario no encontrado");
      }
      res.status(200).send("Usuario eliminado correctamente");
    }
  );
});

//-----------------------------------------------------------------------------------------------------------------------------------

// Obtener todas las marcas
app.get("/marcas", (req, res) => {
  connection.query("SELECT * FROM Marca", (err, rows) => {
    if (err) {
      console.error("Error al obtener las marcas:", err);
      return res.status(500).send("Error de servidor");
    }
    res.json(rows);
  });
});

// Obtener una marca por ID
app.get("/marcas/:id", (req, res) => {
  const { id } = req.params;
  connection.query("SELECT * FROM Marca WHERE m_id = ?", [id], (err, rows) => {
    if (err) {
      console.error("Error al obtener la marca:", err);
      return res.status(500).send("Error de servidor");
    }
    if (rows.length === 0) {
      return res.status(404).send("Marca no encontrada");
    }
    res.json(rows[0]);
  });
});

// Agregar una nueva marca
app.post("/marcas", (req, res) => {
  const { m_nombre } = req.body;
  connection.query(
    "INSERT INTO Marca (m_nombre) VALUES (?)",
    [m_nombre],
    (err, result) => {
      if (err) {
        console.error("Error al agregar la marca:", err);
        return res.status(500).send("Error de servidor");
      }
      res.status(201).send("Marca agregada correctamente");
    }
  );
});

// Actualizar una marca por ID
app.put("/marcas/:id", (req, res) => {
  const { id } = req.params;
  const { m_nombre } = req.body;
  connection.query(
    "UPDATE Marca SET m_nombre = ? WHERE m_id = ?",
    [m_nombre, id],
    (err, result) => {
      if (err) {
        console.error("Error al actualizar la marca:", err);
        return res.status(500).send("Error de servidor");
      }
      if (result.affectedRows === 0) {
        return res.status(404).send("Marca no encontrada");
      }
      res.status(200).send("Marca actualizada correctamente");
    }
  );
});

// Eliminar una marca por ID
app.delete("/marcas/:id", (req, res) => {
  const { id } = req.params;
  connection.query("DELETE FROM Marca WHERE m_id = ?", [id], (err, result) => {
    if (err) {
      console.error("Error al eliminar la marca:", err);
      return res.status(500).send("Error de servidor");
    }
    if (result.affectedRows === 0) {
      return res.status(404).send("Marca no encontrada");
    }
    res.status(200).send("Marca eliminada correctamente");
  });
});

//-----------------------------------------------------------------------------------------------------------------------------------

// Obtener todas las unidades de medida
app.get("/unidades-medida", (req, res) => {
  connection.query("SELECT * FROM UnidadMedida", (err, rows) => {
    if (err) {
      console.error("Error al obtener las unidades de medida:", err);
      return res.status(500).send("Error de servidor");
    }
    res.json(rows);
  });
});

// Obtener una unidad de medida por ID
app.get("/unidades-medida/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "SELECT * FROM UnidadMedida WHERE um_id = ?",
    [id],
    (err, rows) => {
      if (err) {
        console.error("Error al obtener la unidad de medida:", err);
        return res.status(500).send("Error de servidor");
      }
      if (rows.length === 0) {
        return res.status(404).send("Unidad de medida no encontrada");
      }
      res.json(rows[0]);
    }
  );
});

// Agregar una nueva unidad de medida
app.post("/unidades-medida", (req, res) => {
  const { um_id, um_nombre } = req.body;
  connection.query(
    "INSERT INTO UnidadMedida (um_id, um_nombre) VALUES (?, ?)",
    [um_id, um_nombre],
    (err, result) => {
      if (err) {
        console.error("Error al agregar la unidad de medida:", err);
        return res.status(500).send("Error de servidor");
      }
      res.status(201).send("Unidad de medida agregada correctamente");
    }
  );
});

// Actualizar una unidad de medida por ID
app.put("/unidades-medida/:id", (req, res) => {
  const { id } = req.params;
  const { um_nombre } = req.body;
  connection.query(
    "UPDATE UnidadMedida SET um_nombre = ? WHERE um_id = ?",
    [um_nombre, id],
    (err, result) => {
      if (err) {
        console.error("Error al actualizar la unidad de medida:", err);
        return res.status(500).send("Error de servidor");
      }
      if (result.affectedRows === 0) {
        return res.status(404).send("Unidad de medida no encontrada");
      }
      res.status(200).send("Unidad de medida actualizada correctamente");
    }
  );
});

// Eliminar una unidad de medida por ID
app.delete("/unidades-medida/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "DELETE FROM UnidadMedida WHERE um_id = ?",
    [id],
    (err, result) => {
      if (err) {
        console.error("Error al eliminar la unidad de medida:", err);
        return res.status(500).send("Error de servidor");
      }
      if (result.affectedRows === 0) {
        return res.status(404).send("Unidad de medida no encontrada");
      }
      res.status(200).send("Unidad de medida eliminada correctamente");
    }
  );
});

//-----------------------------------------------------------------------------------------------------------------------------------

// Obtener todos los registros de UsuarioAlimento
app.get("/usuario-alimento", (req, res) => {
  connection.query("SELECT * FROM UsuarioAlimento", (err, rows) => {
    if (err) {
      console.error("Error al obtener los registros de UsuarioAlimento:", err);
      return res.status(500).send("Error de servidor");
    }
    res.json(rows);
  });
});

// Obtener los registros de UsuarioAlimento por ID de usuario
app.get("/usuario-alimento/usuario/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "SELECT * FROM UsuarioAlimento WHERE u_id = ?",
    [id],
    (err, rows) => {
      if (err) {
        console.error(
          "Error al obtener los registros de UsuarioAlimento por ID de usuario:",
          err
        );
        return res.status(500).send("Error de servidor");
      }
      res.json(rows);
    }
  );
});

// Obtener los registros de UsuarioAlimento por ID de alimento
app.get("/usuario-alimento/alimento/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "SELECT * FROM UsuarioAlimento WHERE a_id = ?",
    [id],
    (err, rows) => {
      if (err) {
        console.error(
          "Error al obtener los registros de UsuarioAlimento por ID de alimento:",
          err
        );
        return res.status(500).send("Error de servidor");
      }
      res.json(rows);
    }
  );
});

// Agregar un nuevo registro a UsuarioAlimento
app.post("/usuario-alimento", (req, res) => {
  const { u_id, a_id, ua_cantidad, ua_accion } = req.body;
  connection.query(
    "INSERT INTO UsuarioAlimento (u_id, a_id, ua_cantidad, ua_accion) VALUES (?, ?, ?, ?)",
    [u_id, a_id, ua_cantidad, ua_accion],
    (err, result) => {
      if (err) {
        console.error(
          "Error al agregar un nuevo registro a UsuarioAlimento:",
          err
        );
        return res.status(500).send("Error de servidor");
      }
      res
        .status(201)
        .send("Nuevo registro agregado correctamente a UsuarioAlimento");
    }
  );
});

// Eliminar un registro de UsuarioAlimento por ID
app.delete("/usuario-alimento/:id", (req, res) => {
  const { id } = req.params;
  connection.query(
    "DELETE FROM UsuarioAlimento WHERE ua_id = ?",
    [id],
    (err, result) => {
      if (err) {
        console.error("Error al eliminar un registro de UsuarioAlimento:", err);
        return res.status(500).send("Error de servidor");
      }
      if (result.affectedRows === 0) {
        return res
          .status(404)
          .send("Registro de UsuarioAlimento no encontrado");
      }
      res
        .status(200)
        .send("Registro de UsuarioAlimento eliminado correctamente");
    }
  );
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor Express en funcionamiento en el puerto ${PORT}`);
});
