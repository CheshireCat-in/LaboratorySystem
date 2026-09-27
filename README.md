# 高校实验室预约系统

## 环境要求
- JDK 11
- Tomcat 9
- MySQL 8.0

## 运行步骤

### 1. 数据库初始化
在 MySQL 中执行 `sql/init.sql` 建库建表并导入测试数据

### 2. 配置数据库连接
打开 `src/main/java/org/example/util/DBUtil.java`
将 PASSWORD 改为你的 MySQL 密码

### 3. 启动项目
用 IDEA 打开项目，配置 Tomcat 9，启动后访问：
http://localhost:8080/LaboratorySystem

## 测试账号
| 角色   | 用户名     | 密码   |
|--------|-----------|--------|
| 学生   | student01 | 123456 |
| 管理员 | admin01   | 123456 |
