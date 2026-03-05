-- =============================================
-- BookApp Database Schema
-- SQL Server
-- =============================================

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'BookApp')
    DROP DATABASE BookApp;
GO

CREATE DATABASE BookApp;
GO

USE BookApp;
GO

-- =============================================
-- Table: Users
-- =============================================
CREATE TABLE Users (
    id          INT PRIMARY KEY IDENTITY(1,1),
    username    NVARCHAR(50)  NOT NULL UNIQUE,
    password    NVARCHAR(255) NOT NULL,
    fullname    NVARCHAR(100) NOT NULL,
    email       NVARCHAR(100) NOT NULL UNIQUE,
    phone       NVARCHAR(20),
    address     NVARCHAR(255),
    role        NVARCHAR(20)  NOT NULL DEFAULT 'customer', -- admin / customer
    active      BIT           NOT NULL DEFAULT 1,
    created_at  DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- =============================================
-- Table: Categories
-- =============================================
CREATE TABLE Categories (
    id          INT PRIMARY KEY IDENTITY(1,1),
    name        NVARCHAR(100) NOT NULL,
    description NVARCHAR(500)
);
GO

-- =============================================
-- Table: Books
-- =============================================
CREATE TABLE Books (
    id          INT PRIMARY KEY IDENTITY(1,1),
    title       NVARCHAR(255) NOT NULL,
    author      NVARCHAR(100) NOT NULL,
    category_id INT NOT NULL REFERENCES Categories(id),
    price       DECIMAL(18,2) NOT NULL,
    sale_price  DECIMAL(18,2),
    stock       INT NOT NULL DEFAULT 0,
    sold        INT NOT NULL DEFAULT 0,
    description NVARCHAR(MAX),
    image       NVARCHAR(500) DEFAULT 'default.jpg',
    featured    BIT NOT NULL DEFAULT 0,
    active      BIT NOT NULL DEFAULT 1,
    created_at  DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- =============================================
-- Table: Orders
-- =============================================
CREATE TABLE Orders (
    id          INT PRIMARY KEY IDENTITY(1,1),
    user_id     INT NOT NULL REFERENCES Users(id),
    total       DECIMAL(18,2) NOT NULL,
    status      NVARCHAR(50)  NOT NULL DEFAULT N'Chờ xử lý',
    -- Chờ xử lý / Đang giao / Hoàn thành / Đã hủy
    note        NVARCHAR(500),
    address     NVARCHAR(255),
    created_at  DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- =============================================
-- Table: OrderDetails
-- =============================================
CREATE TABLE OrderDetails (
    id          INT PRIMARY KEY IDENTITY(1,1),
    order_id    INT NOT NULL REFERENCES Orders(id),
    book_id     INT NOT NULL REFERENCES Books(id),
    quantity    INT NOT NULL,
    price       DECIMAL(18,2) NOT NULL
);
GO

-- =============================================
-- Table: Cart
-- =============================================
CREATE TABLE Cart (
    id          INT PRIMARY KEY IDENTITY(1,1),
    user_id     INT NOT NULL REFERENCES Users(id),
    book_id     INT NOT NULL REFERENCES Books(id),
    quantity    INT NOT NULL DEFAULT 1,
    UNIQUE(user_id, book_id)
);
GO
