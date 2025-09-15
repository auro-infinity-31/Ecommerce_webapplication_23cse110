<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login | E-Shop</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');
        * { box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .overlay {
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.65);
            z-index: 0;
        }

        .login-container {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(16px);
            border-radius: 16px;
            padding: 3rem 2.5rem;
            width: 100%;
            max-width: 420px;
            color: #fff;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }

        .login-container h2 {
            text-align: center;
            font-size: 2rem;
            background: linear-gradient(to right, #6dd5fa, #00b894);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 2rem;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 0.4rem;
            font-size: 0.9rem;
        }

        input, select {
            padding: 0.8rem;
            margin-bottom: 1.2rem;
            border: none;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.95);
            font-size: 1rem;
            color: #333;
        }

        input:focus, select:focus {
            outline: none;
            box-shadow: 0 0 4px #00cec9;
        }

        .btn {
            padding: 0.9rem;
            background: #00cec9;
            color: #fff;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #00b4b1;
        }

        .message-box {
            background: rgba(255,255,255,0.9);
            color: #d63031;
            padding: 10px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 1rem;
            font-weight: bold;
            transition: opacity 0.5s ease;
        }

        .switch-link {
            margin-top: 1.2rem;
            text-align: center;
            font-size: 0.9rem;
        }

        .switch-link a {
            color: #81ecec;
            text-decoration: none;
        }

        .switch-link a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
<div class="overlay"></div>
<div class="login-container">
    <h2>🔐 Login to E-Shop</h2>

    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
        <div class="message-box"><%= msg %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
        <label>Login as</label>
        <select name="role" required>
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select>

        <label>Email</label>
        <input type="email" name="email" placeholder="example@email.com" required>

        <label>Password</label>
        <input type="password" name="password" placeholder="Enter your password" required>

        

        <button class="btn" type="submit">Login</button>
    </form>
    <script>
    const msgBox = document.querySelector('.message-box');
    if (msgBox) {
        setTimeout(() => {
            msgBox.style.opacity = '0';
            setTimeout(() => msgBox.style.display = 'none', 500);
        }, 2000);
    }

    </script>


    <div class="switch-link">
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</div>
</body>
</html>
