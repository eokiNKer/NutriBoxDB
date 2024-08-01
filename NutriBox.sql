-- Seleciona o database para uso
USE NutriBox;

-- Cria a tabela usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(255) NOT NULL,
    classe_usuario ENUM('admin', 'cliente') NOT NULL,
    senha_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL UNIQUE,
    telefone_usuario VARCHAR(20)
);

-- Cria a tabela enderecos_usuario
CREATE TABLE enderecos_usuario (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    endereco TEXT NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    cep VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Cria a tabela categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(255) NOT NULL
);

-- Cria a tabela marmitas
CREATE TABLE marmitas (
    id_marmita INT AUTO_INCREMENT PRIMARY KEY,
    nome_marmita VARCHAR(255) NOT NULL,
    descricao_marmita TEXT NOT NULL,
    preco_marmita DECIMAL(10, 2) NOT NULL,
    calorias_marmita INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Cria a tabela pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    data_pedido DATETIME NOT NULL,
    status_pedido ENUM('pendente', 'em_preparacao', 'enviado', 'entregue') NOT NULL,
    total_pedido DECIMAL(10, 2) NOT NULL,
    id_endereco INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_endereco) REFERENCES enderecos_usuario(id_endereco)
);

-- Cria a tabela itens_pedido
CREATE TABLE itens_pedido (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_marmita INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_marmita) REFERENCES marmitas(id_marmita)
);

-- Cria a tabela pagamentos
CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    metodo_pagamento ENUM('cartao_credito', 'boleto', 'pix') NOT NULL,
    status_pagamento ENUM('pendente', 'pago', 'cancelado') NOT NULL,
    data_pagamento DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- Cria a tabela niveis_usuario
CREATE TABLE niveis_usuario (
    id_nivel INT AUTO_INCREMENT PRIMARY KEY,
    nome_nivel VARCHAR(255) NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL
);

-- Cria a tabela pontos_usuario
CREATE TABLE pontos_usuario (
    id_pontos INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    pontos INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
