CREATE SCHEMA IF NOT EXISTS `academia` DEFAULT CHARACTER SET utf8 ;
USE `academia` ;

-- -----------------------------------------------------
-- Table `academia`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`login` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`calc_imc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`calc_imc` (
  `id_imc` INT NOT NULL AUTO_INCREMENT,
  `peso` DECIMAL(5,2) NOT NULL,
  `altura` DECIMAL(5,2) NOT NULL,
  `resultado` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id_imc`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`histor_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`histor_pagamento` (
  `idhistor_pagamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `plano` VARCHAR(255) NOT NULL,
  `data_pagamento` DATE NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idhistor_pagamento`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`agenda_avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`agenda_avaliacao` (
  `idagend_avaliacao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) DEFAULT NULL,
  `horario` VARCHAR(5) NOT NULL,
  `segunda` TINYINT(1) NOT NULL,
  `terca` TINYINT(1) NOT NULL,
  `quarta` TINYINT(1) NOT NULL,
  `quinta` TINYINT(1) NOT NULL,
  `sexta` TINYINT(1) NOT NULL,
  `sabado` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idagend_avaliacao`)
)
ENGINE = InnoDB;

ALTER TABLE `academia`.`agenda_avaliacao`
    MODIFY `segunda` TINYINT(1) NOT NULL DEFAULT 0,
    MODIFY `terca` TINYINT(1) NOT NULL DEFAULT 0,
    MODIFY `quarta` TINYINT(1) NOT NULL DEFAULT 0,
    MODIFY `quinta` TINYINT(1) NOT NULL DEFAULT 0,
    MODIFY `sexta` TINYINT(1) NOT NULL DEFAULT 0,
    MODIFY `sabado` TINYINT(1) NOT NULL DEFAULT 0;
-- -----------------------------------------------------
-- Table `academia`.`cadastro_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`cadastro_aluno` (
  `idcadastro` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `sobrenome` VARCHAR(50) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `rg` VARCHAR(13) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `bairro` VARCHAR(50) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(50) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `matricula` VARCHAR(255) NOT NULL,
  `histor_pagamento_idhistor_pagamento` INT NOT NULL,
  `agenda_avaliacao_idagend_avaliacao` INT NOT NULL,
  PRIMARY KEY (`idcadastro`),
  INDEX `fk_cadastro_aluno_histor_pagamento1_idx` (`histor_pagamento_idhistor_pagamento` ASC) VISIBLE,
  INDEX `fk_cadastro_aluno_agenda_avaliacao1_idx` (`agenda_avaliacao_idagend_avaliacao` ASC) VISIBLE,
  CONSTRAINT `fk_cadastro_aluno_histor_pagamento1`
    FOREIGN KEY (`histor_pagamento_idhistor_pagamento`)
    REFERENCES `academia`.`histor_pagamento` (`idhistor_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cadastro_aluno_agenda_avaliacao1`
    FOREIGN KEY (`agenda_avaliacao_idagend_avaliacao`)
    REFERENCES `academia`.`agenda_avaliacao` (`idagend_avaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE cadastro_aluno MODIFY COLUMN matricula VARCHAR(255) DEFAULT NULL;
ALTER TABLE cadastro_aluno MODIFY COLUMN histor_pagamento_idhistor_pagamento INT DEFAULT NULL;
ALTER TABLE cadastro_aluno MODIFY COLUMN agenda_avaliacao_idagend_avaliacao INT DEFAULT NULL;
-- -----------------------------------------------------
-- Table `academia`.`cadastro_instrutor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`cadastro_instrutor` (
  `idcadastroinst` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `sobrenome` VARCHAR(50) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `rg` VARCHAR(13) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `bairro` VARCHAR(50) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(50) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `matricula` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idcadastroinst`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`control_pagment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`control_pagment` (
  `id_pagment` INT NOT NULL AUTO_INCREMENT,
  `aluno` VARCHAR(50) NOT NULL,
  `plano` VARCHAR(20) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `vencimento` DATE NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `cadastro_aluno_idcadastro` INT NOT NULL,
  PRIMARY KEY (`id_pagment`),
  INDEX `fk_control_pagment_cadastro_aluno1_idx` (`cadastro_aluno_idcadastro` ASC) VISIBLE,
  CONSTRAINT `fk_control_pagment_cadastro_aluno1`
    FOREIGN KEY (`cadastro_aluno_idcadastro`)
    REFERENCES `academia`.`cadastro_aluno` (`idcadastro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`treino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`treino` (
  `idtreino` INT NOT NULL AUTO_INCREMENT,
  `aparelho` VARCHAR(255) NOT NULL,
  `serie` VARCHAR(255) NOT NULL,
  `repeticao` VARCHAR(255) NOT NULL,
  `carga` FLOAT NOT NULL,
  `tipo_treino` VARCHAR(255) NOT NULL,
  `cadastro_aluno_idcadastro` INT NOT NULL,
  PRIMARY KEY (`idtreino`),
  INDEX `fk_treino_cadastro_aluno1_idx` (`cadastro_aluno_idcadastro` ASC) VISIBLE,
  CONSTRAINT `fk_treino_cadastro_aluno1`
    FOREIGN KEY (`cadastro_aluno_idcadastro`)
    REFERENCES `academia`.`cadastro_aluno` (`idcadastro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`ficha_treino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`ficha_treino` (
  `idficha` INT NOT NULL AUTO_INCREMENT,
  `aparelho` VARCHAR(255) NOT NULL,
  `serie` VARCHAR(255) NOT NULL,
  `repeticao` VARCHAR(255) NOT NULL,
  `carga` FLOAT NOT NULL,
  `tipo_treino` VARCHAR(255) NOT NULL,
  `treino_idtreino` INT NOT NULL,
  PRIMARY KEY (`idficha`),
  INDEX `fk_ficha_treino_treino1_idx` (`treino_idtreino` ASC) VISIBLE,
  CONSTRAINT `fk_ficha_treino_treino1`
    FOREIGN KEY (`treino_idtreino`)
    REFERENCES `academia`.`treino` (`idtreino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`regis_matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`regis_matricula` (
  `idregis_matricula` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(255) NOT NULL,
  `cadastro_aluno_idcadastro` INT NOT NULL,
  PRIMARY KEY (`idregis_matricula`),
  INDEX `fk_regis_matricula_cadastro_aluno1_idx` (`cadastro_aluno_idcadastro` ASC) VISIBLE,
  CONSTRAINT `fk_regis_matricula_cadastro_aluno1`
    FOREIGN KEY (`cadastro_aluno_idcadastro`)
    REFERENCES `academia`.`cadastro_aluno` (`idcadastro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`avaliacao_fisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`avaliacao_fisica` (
  `idavaliacao_fisica` INT NOT NULL AUTO_INCREMENT,
  `braco` FLOAT NULL,
  `antebraco` FLOAT NULL,
  `peito` FLOAT NULL,
  `cintura` FLOAT NULL,
  `quadril` FLOAT NULL,
  `coxa` FLOAT NULL,
  `panturrilha` FLOAT NULL,
  `altura` FLOAT NULL,
  `peso` FLOAT NULL,
  `cadastro_aluno_idcadastro` INT NOT NULL,
  `treino_idtreino` INT NOT NULL,
  PRIMARY KEY (`idavaliacao_fisica`),
  INDEX `fk_avaliacao_fisica_cadastro_aluno1_idx` (`cadastro_aluno_idcadastro` ASC) VISIBLE,
  INDEX `fk_avaliacao_fisica_treino1_idx` (`treino_idtreino` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_fisica_cadastro_aluno1`
    FOREIGN KEY (`cadastro_aluno_idcadastro`)
    REFERENCES `academia`.`cadastro_aluno` (`idcadastro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_fisica_treino1`
    FOREIGN KEY (`treino_idtreino`)
    REFERENCES `academia`.`treino` (`idtreino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`regis_avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`regis_avaliacao` (
  `idregis_avaliacao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  `data` DATE NULL,
  `hora` VARCHAR(255) NULL,
  `cadastro_aluno_idcadastro` INT NOT NULL,
  PRIMARY KEY (`idregis_avaliacao`),
  INDEX `fk_regis_avaliacao_cadastro_aluno1_idx` (`cadastro_aluno_idcadastro` ASC) VISIBLE,
  CONSTRAINT `fk_regis_avaliacao_cadastro_aluno1`
    FOREIGN KEY (`cadastro_aluno_idcadastro`)
    REFERENCES `academia`.`cadastro_aluno` (`idcadastro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`controle_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`controle_frequencia` (
  `idcontrole_frequencia` INT NOT NULL AUTO_INCREMENT,
  `horario` VARCHAR(5) NULL,
  `segunda` TINYINT(1) NOT NULL,
  `terca` TINYINT(1) NOT NULL DEFAULT 0,
  `quarta` TINYINT(1) NOT NULL,
  `quinta` TINYINT(1) NOT NULL,
  `sexta` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idcontrole_frequencia`)
)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`grade_horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academia`.`grade_horario` (
  `idgrade_horario` INT NOT NULL AUTO_INCREMENT,
  `horario_inicio` TIME NOT NULL,
  `horario_fim` TIME NOT NULL,
  `segunda` VARCHAR(255) NOT NULL,
  `terca` VARCHAR(255) NOT NULL,
  `quarta` VARCHAR(255) NOT NULL,
  `quinta` VARCHAR(255) NOT NULL,
  `sexta` VARCHAR(255) NOT NULL,
  `cadastro_instrutor_idcadastroinst` INT NOT NULL,
  PRIMARY KEY (`idgrade_horario`),
  INDEX `fk_grade_horario_cadastro_instrutor1_idx` (`cadastro_instrutor_idcadastroinst` ASC) VISIBLE,
  CONSTRAINT `fk_grade_horario_cadastro_instrutor1`
    FOREIGN KEY (`cadastro_instrutor_idcadastroinst`)
    REFERENCES `academia`.`cadastro_instrutor` (`idcadastroinst`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `academia`.`login`
-- -----------------------------------------------------
INSERT INTO `academia`.`login`
(`email`, `senha`)
VALUES
('admin1@teste.com', '1234'),
('admin2@teste.com', '1234'),
('felipe@teste.com', '1234'),
('joao@teste.com', '1234');
-- -----------------------------------------------------
-- Table `academia`.`calc_imc`
-- -----------------------------------------------------
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (70.00, 1.75, 22.86);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (65.00, 1.70, 22.49);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (75.00, 1.80, 23.15);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (80.00, 1.90, 22.16);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (68.00, 1.65, 24.98);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (72.00, 1.68, 25.51);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (77.00, 1.77, 24.59);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (82.00, 1.85, 23.94);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (90.00, 1.88, 25.47);
INSERT INTO `academia`.`calc_imc` (`peso`, `altura`, `resultado`) VALUES (85.00, 1.82, 25.66);
-- -----------------------------------------------------
-- Table `academia`.`histor_pagamento`
-- -----------------------------------------------------
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('João Silva', 'Mensal', '2023-06-01', 100.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Ana Maria', 'Mensal', '2023-06-02', 50.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Carlos Eduardo', 'Anual', '2023-06-03', 100.00, 'Atrasado');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Bianca Santos', 'Anual', '2023-06-04', 100.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Felipe Costa', 'Mensal', '2023-06-05', 50.00, 'Atrasado');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Mariana Moraes', 'Anual', '2023-06-06', 100.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Lucas Pereira', 'Mensal', '2023-06-07', 50.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Isabela Fernandes', 'Anual', '2023-06-08', 100.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Rodrigo Soares', 'Mensal', '2023-06-09', 50.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Camila Rocha', 'Anual', '2023-06-10', 100.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Paloma Aguiar', 'Mensal', '2023-06-20', 50.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Renan Souza', 'Anual', '2023-06-21', 100.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Gustavo Rodrigues', 'Mensal', '2023-06-22', 50.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Jorge Henrique', 'Mensal', '2023-06-22', 50.00, 'Pago');
INSERT INTO `academia`.`histor_pagamento` (`nome`, `plano`, `data_pagamento`, `valor`, `status`) VALUES ('Pedro Marcedo', 'Anual', '2023-06-23', 100.00, 'Atrasado');
-- -----------------------------------------------------
-- Table `academia`.`agenda_avaliacao`
-- -----------------------------------------------------
INSERT INTO `academia`.`agenda_avaliacao` 
(`nome`, `horario`, `segunda`, `terca`, `quarta`, `quinta`, `sexta`, `sabado`)
VALUES ('Maria', '08:00', 1, 0, 1, 0, 1, 0);
INSERT INTO `academia`.`agenda_avaliacao` 
(`nome`, `horario`, `segunda`, `terca`, `quarta`, `quinta`, `sexta`, `sabado`)
VALUES ('Jane', '10:00', 0, 1, 0, 1, 0, 1);
INSERT INTO `academia`.`agenda_avaliacao` 
(`nome`, `horario`, `segunda`, `terca`, `quarta`, `quinta`, `sexta`, `sabado`)
VALUES ('Roberto', '14:00', 1, 1, 1, 0, 0, 0);
INSERT INTO `academia`.`agenda_avaliacao` 
(`nome`, `horario`, `segunda`, `terca`, `quarta`, `quinta`, `sexta`, `sabado`)
VALUES ('Aline', '16:00', 0, 0, 0, 1, 1, 0);
INSERT INTO `academia`.`agenda_avaliacao` 
(`nome`, `horario`, `segunda`, `terca`, `quarta`, `quinta`, `sexta`, `sabado`)
VALUES ('Aline', '16:00', 1, 0, 1, 0, 0, 1);
-- -----------------------------------------------------
-- Table `academia`.`cadastro_aluno`
-- -----------------------------------------------------
INSERT INTO `academia`.`cadastro_aluno`
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`, `histor_pagamento_idhistor_pagamento`, `agenda_avaliacao_idagend_avaliacao`)
VALUES
('João', 'Silva', '2000-01-01', '1234567890', '12345678901', 'Rua Principal', '10', 'Centro', 'SP', 'São Paulo', '01234567', 'joao.silva@example.com', '(51) 998547825', 'joaosilva', '3182931', '231723', 1, 1);
INSERT INTO `academia`.`cadastro_aluno` (`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`, `histor_pagamento_idhistor_pagamento`, `agenda_avaliacao_idagend_avaliacao`) VALUES
('José', 'Ferreira', '1995-09-15', '789012345', '78901234567', 'Rua das Flores', '50', 'Centro', 'SP', 'São Paulo', '01234567', 'jose.ferreira@example.com', '(11) 123456789', 'joseferreira', '7654321', '528458', 3, 3),
('Ana', 'Santos', '1997-07-20', '456789012', '45678901234', 'Avenida das Árvores', '100', 'Jardins', 'MG', 'Belo Horizonte', '30000123', 'ana.santos@example.com', '(31) 987654321', 'anasantos', '5432167', '998548', 1, 2),
('Carlos', 'Oliveira', '1998-04-10', '123456789', '12345678901', 'Rua do Sol', '25', 'Vila Nova', 'RJ', 'Rio de Janeiro', '20000789', 'carlos.oliveira@example.com', '(21) 987654321', 'carlosoliveira', '9876543', '567854', 2, 1),
('Mariana', 'Gomes', '1996-11-25', '987654321', '98765432109', 'Avenida Principal', '30', 'Praia', 'SC', 'Florianópolis', '88000456', 'mariana.gomes@example.com', '(48) 987654321', 'marianagomes', '3456789', '254785', 3, 1),
('Lucas', 'Silva', '1999-03-05', '456789012', '45678901234', 'Rua das Estrelas', '15', 'Morumbi', 'SP', 'São Paulo', '01234567', 'lucas.silva@example.com', '(11) 987654321', 'lucassilva', '5678901', '547814', 1, 3);
INSERT INTO `academia`.`cadastro_aluno` (`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`, `histor_pagamento_idhistor_pagamento`, `agenda_avaliacao_idagend_avaliacao`) VALUES
('Fernanda', 'Almeida', '1997-08-12', '123456789', '12345678901', 'Rua das Palmeiras', '50', 'Jardim', 'RJ', 'Rio de Janeiro', '20000123', 'fernanda.almeida@example.com', '(21) 987654321', 'fernandaalmeida', '87654321', '598895', 1, 2),
('Ricardo', 'Martins', '1996-05-18', '987654321', '98765432109', 'Avenida Central', '100', 'Centro', 'SP', 'São Paulo', '01234567', 'ricardo.martins@example.com', '(11) 987654321', 'ricardomartins', '76543210', '568745', 2, 3),
('Camila', 'Pereira', '1998-02-27', '456789012', '45678901234', 'Rua dos Girassóis', '25', 'Flores', 'MG', 'Belo Horizonte', '30000456', 'camila.pereira@example.com', '(31) 987654321', 'camilapereira', '54321098', '254789', 3, 1),
('Gustavo', 'Rocha', '1999-10-09', '789012345', '78901234567', 'Avenida Principal', '30', 'Centro', 'SC', 'Florianópolis', '88000789', 'gustavo.rocha@example.com', '(48) 987654321', 'gustavorocha', '21098765', '558795', 1, 2),
('Sandra', 'Melo', '1995-12-24', '456789012', '45678901234', 'Rua das Estrelas', '15', 'Morumbi', 'SP', 'São Paulo', '01234567', 'sandra.melo@example.com', '(11) 987654321', 'sandramelo', '87654321', '554789', 2, 1);
-- -----------------------------------------------------
-- Table `academia`.`cadastro_instrutor`
-- -----------------------------------------------------
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('John', 'Doe', '1990-01-01', '123456789', '12345678901', 'Rua A', '10', 'Centro', 'SP', 'São Paulo', '12345678', 'john.doe@example.com', '1234567890', 'johndoe', 'senha123', 'M001');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Jane', 'Smith', '1985-03-15', '987654321', '09876543210', 'Rua B', '20', 'Jardim', 'RJ', 'Rio de Janeiro', '98765432', 'jane.smith@example.com', '0987654321', 'janesmith', 'senha456', 'M002');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Michael', 'Johnson', '1988-07-20', '456789123', '54321678901', 'Rua C', '30', 'Vila', 'MG', 'Belo Horizonte', '65432198', 'michael.johnson@example.com', '9876543210', 'michaeljohnson', 'senha789', 'M003');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Emily', 'Brown', '1992-05-10', '321654987', '01234567890', 'Rua D', '40', 'Parque', 'SC', 'Florianópolis', '87654321', 'emily.brown@example.com', '0123456789', 'emilybrown', 'senhaabc', 'M004');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Daniel', 'Taylor', '1987-12-05', '789123456', '54321098765', 'Rua E', '50', 'Lagoa', 'RS', 'Porto Alegre', '56789123', 'daniel.taylor@example.com', '987654321', 'danieltaylor', 'senhabcd', 'M005');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Olivia', 'Johnson', '1991-09-25', '654987321', '09876543219', 'Rua F', '60', 'Jardim', 'SP', 'Campinas', '43219876', 'olivia.johnson@example.com', '876543210', 'oliviajohnson', 'senha1234', 'M006');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('James', 'Wilson', '1986-06-12', '987654987', '12345678912', 'Rua G', '70', 'Centro', 'RJ', 'Niterói', '98765412', 'james.wilson@example.com', '765432109', 'jameswilson', 'senha5678', 'M007');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Sophia', 'Miller', '1993-02-18', '123789456', '54321098776', 'Rua H', '80', 'Vila', 'MG', 'Uberlândia', '76543219', 'sophia.miller@example.com', '654321098', 'sophiamiller', 'senha9012', 'M008');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Benjamin', 'Clark', '1989-11-08', '321789654', '98765432109', 'Rua I', '90', 'Parque', 'SC', 'Joinville', '32198765', 'benjamin.clark@example.com', '5432109876', 'benjaminclark', 'senha3456', 'M009');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Ava', 'Anderson', '1994-07-30', '789654123', '54321098765', 'Rua J', '100', 'Lagoa', 'RS', 'Caxias do Sul', '87654321', 'ava.anderson@example.com', '4321098765', 'avaanderson', 'senha7890', 'M010');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Liam', 'Walker', '1987-04-02', '123987456', '01234567890', 'Rua K', '110', 'Centro', 'SP', 'São José dos Campos', '45678901', 'liam.walker@example.com', '7654321098', 'liamwalker', 'senha2345', 'M011');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Isabella', 'Harris', '1990-12-18', '987654123', '09876543210', 'Rua L', '120', 'Jardim', 'RJ', 'Nova Iguaçu', '98765432', 'isabella.harris@example.com', '1098765432', 'isabellaharris', 'senha5678', 'M012');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Mason', 'Garcia', '1988-09-07', '456123789', '54321678901', 'Rua M', '130', 'Vila', 'MG', 'Belo Horizonte', '87654321', 'mason.garcia@example.com', '9876543210', 'masongarcia', 'senha8901', 'M013');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('Ella', 'Martinez', '1992-03-25', '789123456', '09876543210', 'Rua N', '140', 'Parque', 'SC', 'Florianópolis', '65432198', 'ella.martinez@example.com', '8765432198', 'ellamartinez', 'senha0123', 'M014');
INSERT INTO `academia`.`cadastro_instrutor` 
(`nome`, `sobrenome`, `data_nascimento`, `rg`, `cpf`, `rua`, `numero`, `bairro`, `estado`, `cidade`, `cep`, `email`, `telefone`, `login`, `senha`, `matricula`)
VALUES ('William', 'Lopez', '1989-08-11', '321654987', '54321098765', 'Rua O', '150', 'Lagoa', 'RS', 'Porto Alegre', '56789123', 'william.lopez@example.com', '6543210987', 'williamlopez', 'senha3456', 'M015');
-- -----------------------------------------------------
-- Table `academia`.`control_pagment`
-- -----------------------------------------------------
INSERT INTO `academia`.`control_pagment`
(`aluno`, `plano`, `valor`, `vencimento`, `status`, `cadastro_aluno_idcadastro`)
VALUES
('João Silva', 'Mensal', 100.00, '2023-06-10', 'Pago', 1),
('Maria Lima', 'Anual', 150.00, '2023-06-10', 'Pendente', 2),
('Pedro Santos', 'Mensal', 200.00, '2023-06-10', 'Atrasado', 3),
('Ana Oliveira', 'Anual', 100.00, '2023-06-10', 'Pago', 4),
('Carlos Almeida', 'Mensal', 150.00, '2023-06-10', 'Pendente', 5),
('Mariana Gomes', 'Anual', 200.00, '2023-06-10', 'Atrasado', 6),
('Lucas Silva', 'Mensal', 100.00, '2023-06-10', 'Pago', 7),
('Fernanda Costa', 'Anual', 150.00, '2023-06-10', 'Pendente', 8),
('Ricardo Martins', 'Mensal', 200.00, '2023-06-10', 'Atrasado', 9),
('Camila Pereira', 'Anual', 100.00, '2023-06-10', 'Pago', 10);
-- -----------------------------------------------------
-- Table `academia`.`treino`
-- -----------------------------------------------------
INSERT INTO `academia`.`treino`
(`aparelho`, `serie`, `repeticao`, `carga`, `tipo_treino`, `cadastro_aluno_idcadastro`)
VALUES
('Supino Reto', '3', '8', 50.0, 'A', 1),
('Supino Inclinado', '3', '20', 5, 'A', 2),
('Desenvolvimento Ombro', '3', '8', 25.0, 'A', 3),
('Puxada Alta', '3', '8', 40.0, 'B', 4),
('Rosca Direta', '3', '8', 20.0, 'B', 5),
('Abdominal', '3', '8', 0.0, 'B', 6),
('Esteira', '0', '0', 0, 'C', 7),
('Leg Press', '3', '8', 100.0, 'C', 8),
('Agachamento Livre', '3', '10', 80.0, 'C', 9);
-- -----------------------------------------------------
-- Table `academia`.`avaliacao_fisica`
-- -----------------------------------------------------
INSERT INTO `academia`.`avaliacao_fisica`
(`braco`, `antebraco`, `peito`, `cintura`, `quadril`, `coxa`, `panturrilha`, `altura`, `peso`, `cadastro_aluno_idcadastro`, `treino_idtreino`)
VALUES
(30.0, 25.0, 90.0, 70.0, 95.0, 60.0, 35.0, 170.0, 70.0, 1, 1),
(32.5, 27.5, 95.0, 75.0, 100.0, 65.0, 37.5, 165.0, 65.0, 2, 2),
(35.0, 30.0, 100.0, 80.0, 105.0, 70.0, 40.0, 160.0, 60.0, 3, 3),
(37.5, 32.5, 105.0, 85.0, 110.0, 75.0, 42.5, 155.0, 55.0, 4, 4),
(40.0, 35.0, 110.0, 90.0, 115.0, 80.0, 45.0, 150.0, 50.0, 5, 5),
(42.5, 37.5, 115.0, 95.0, 120.0, 85.0, 47.5, 145.0, 45.0, 6, 6),
(45.0, 40.0, 120.0, 100.0, 125.0, 90.0, 50.0, 140.0, 40.0, 7, 7),
(47.5, 42.5, 125.0, 105.0, 130.0, 95.0, 52.5, 135.0, 35.0, 8, 8),
(50.0, 45.0, 130.0, 110.0, 135.0, 100.0, 55.0, 130.0, 30.0, 9, 9);
-- -----------------------------------------------------
-- Table `academia`.`regis_avaliacao`
-- -----------------------------------------------------
INSERT INTO `academia`.`regis_avaliacao`
(`nome`, `data`, `hora`, `cadastro_aluno_idcadastro`)
VALUES
('Avaliação 1', '2022-01-01', '08:00', 1),
('Avaliação 2', '2022-02-02', '10:00', 2),
('Avaliação 3', '2022-03-03', '14:00', 3),
('Avaliação 4', '2022-04-04', '16:00', 4),
('Avaliação 5', '2022-05-05', '10:00', 5),
('Avaliação 6', '2022-06-06', '14:00', 6),
('Avaliação 7', '2023-01-07', '16:00', 7),
('Avaliação 8', '2023-02-08', '10:00', 8),
('Avaliação 9', '2023-03-09', '08:00', 9),
('Avaliação 10', '2023-04-10', '16:00', 10);