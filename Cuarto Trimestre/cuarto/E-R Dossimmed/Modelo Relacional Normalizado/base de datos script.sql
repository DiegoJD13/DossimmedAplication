-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dossimmed
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dossimmed
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dossimmed` DEFAULT CHARACTER SET utf8 ;
USE `dossimmed` ;

-- -----------------------------------------------------
-- Table `dossimmed`.`Tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Tiendas` (
  `ID_Tienda` INT NOT NULL,
  `Direccion_Tienda` VARCHAR(45) NOT NULL,
  `Nombre_Tienda` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Tienda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Usuarios` (
  `ID_Usuario` INT NOT NULL,
  `PrimerNombre_Usuario` VARCHAR(45) NOT NULL,
  `SegundoNombre_Usuario` VARCHAR(45) NOT NULL,
  `PrimerApellido_Usuario` VARCHAR(45) NOT NULL,
  `SegundoApellido_Usuario` VARCHAR(45) NOT NULL,
  `Correo_Usuario` VARCHAR(45) NOT NULL,
  `Login_Usuario` VARCHAR(45) NOT NULL,
  `Contrasena_Usuario` VARCHAR(45) NOT NULL,
  `Telefono_Usuario` INT NOT NULL,
  `Tiendas_ID_Tienda` INT NOT NULL,
  PRIMARY KEY (`ID_Usuario`),
  INDEX `fk_Usuarios_Tiendas1_idx` (`Tiendas_ID_Tienda` ASC),
  CONSTRAINT `fk_Usuarios_Tiendas1`
    FOREIGN KEY (`Tiendas_ID_Tienda`)
    REFERENCES `dossimmed`.`Tiendas` (`ID_Tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Roles` (
  `ID_Rol` INT NOT NULL,
  `Nombre_Rol` VARCHAR(45) NOT NULL,
  `Usuarios_ID_Usuario` INT NOT NULL,
  PRIMARY KEY (`ID_Rol`),
  INDEX `fk_Rol_Usuarios_idx` (`Usuarios_ID_Usuario` ASC),
  CONSTRAINT `fk_Rol_Usuarios`
    FOREIGN KEY (`Usuarios_ID_Usuario`)
    REFERENCES `dossimmed`.`Usuarios` (`ID_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Modulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Modulos` (
  `ID_Modulo` INT NOT NULL,
  `Nombre_Modulo` VARCHAR(45) NOT NULL,
  `Rol_ID_Rol` INT NOT NULL,
  PRIMARY KEY (`ID_Modulo`),
  INDEX `fk_Modulo_Rol1_idx` (`Rol_ID_Rol` ASC),
  CONSTRAINT `fk_Modulo_Rol1`
    FOREIGN KEY (`Rol_ID_Rol`)
    REFERENCES `dossimmed`.`Roles` (`ID_Rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Metas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Metas` (
  `ID_Metas` INT NOT NULL,
  `Valor_Meta` FLOAT NOT NULL,
  `Fecha_Incio_Meta` DATE NOT NULL,
  `Fecha_Fin_Meta` DATE NOT NULL,
  `Porcentaje_Meta` DECIMAL NOT NULL,
  PRIMARY KEY (`ID_Metas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Ventas` (
  `ID_Venta` INT NOT NULL,
  `Valor_Ventas` DOUBLE NOT NULL,
  `Fecha_Ventas` DATE NOT NULL,
  `Tiendas_ID_Tienda` INT NOT NULL,
  `Metas_ID_Metas` INT NOT NULL,
  PRIMARY KEY (`ID_Venta`),
  INDEX `fk_Ventas_Tiendas1_idx` (`Tiendas_ID_Tienda` ASC),
  INDEX `fk_Ventas_Metas1_idx` (`Metas_ID_Metas` ASC),
  CONSTRAINT `fk_Ventas_Tiendas1`
    FOREIGN KEY (`Tiendas_ID_Tienda`)
    REFERENCES `dossimmed`.`Tiendas` (`ID_Tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ventas_Metas1`
    FOREIGN KEY (`Metas_ID_Metas`)
    REFERENCES `dossimmed`.`Metas` (`ID_Metas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Inventario` (
  `ID_Inventario` INT NOT NULL,
  `Fecha_Inventario` DATE NOT NULL,
  `cantidadProducto_Inventario` INT NOT NULL,
  PRIMARY KEY (`ID_Inventario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Productos` (
  `Serial_Producto` INT NOT NULL,
  `Nombre_Producto` VARCHAR(45) NOT NULL,
  `Tipo_Producto` VARCHAR(45) NOT NULL,
  `Descrip_Producto` VARCHAR(45) NOT NULL,
  `Valor_Producto` FLOAT NOT NULL,
  `Tiendas_ID_Tienda` INT NOT NULL,
  `Inventario_ID_Inventario` INT NOT NULL,
  PRIMARY KEY (`Serial_Producto`),
  INDEX `fk_Producto_Tiendas1_idx` (`Tiendas_ID_Tienda` ASC),
  INDEX `fk_Productos_Inventario1_idx` (`Inventario_ID_Inventario` ASC),
  CONSTRAINT `fk_Producto_Tiendas1`
    FOREIGN KEY (`Tiendas_ID_Tienda`)
    REFERENCES `dossimmed`.`Tiendas` (`ID_Tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Inventario1`
    FOREIGN KEY (`Inventario_ID_Inventario`)
    REFERENCES `dossimmed`.`Inventario` (`ID_Inventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Reportes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Reportes` (
  `ID_Reportes` INT NOT NULL,
  `Nombre_Reporte` VARCHAR(45) NOT NULL,
  `Fecha_Reporte` DATE NOT NULL,
  `Ventas_ID_Venta` INT NOT NULL,
  PRIMARY KEY (`ID_Reportes`),
  INDEX `fk_Reportes_Ventas1_idx` (`Ventas_ID_Venta` ASC),
  CONSTRAINT `fk_Reportes_Ventas1`
    FOREIGN KEY (`Ventas_ID_Venta`)
    REFERENCES `dossimmed`.`Ventas` (`ID_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Alertas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Alertas` (
  `ID_Alertas` INT NOT NULL,
  `Nombre_Alerta` VARCHAR(45) NOT NULL,
  `Mensaje_Alerta` VARCHAR(45) NOT NULL,
  `Fecha_Alerta` DATE NOT NULL,
  `Inventario_ID_Inventario` INT NOT NULL,
  PRIMARY KEY (`ID_Alertas`),
  INDEX `fk_Alertas_Inventario1_idx` (`Inventario_ID_Inventario` ASC),
  CONSTRAINT `fk_Alertas_Inventario1`
    FOREIGN KEY (`Inventario_ID_Inventario`)
    REFERENCES `dossimmed`.`Inventario` (`ID_Inventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dossimmed`.`Zonas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dossimmed`.`Zonas` (
  `ID_Zona` INT NOT NULL,
  `Nombre_Zona` VARCHAR(45) NOT NULL,
  `Metas_ID_Metas` INT NOT NULL,
  PRIMARY KEY (`ID_Zona`),
  INDEX `fk_Zonas_Metas1_idx` (`Metas_ID_Metas` ASC),
  CONSTRAINT `fk_Zonas_Metas1`
    FOREIGN KEY (`Metas_ID_Metas`)
    REFERENCES `dossimmed`.`Metas` (`ID_Metas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
