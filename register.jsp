<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register | E-Shop</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');
        * { box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1601597111173-ea20abf8a17e?auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover;
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

        .register-container {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(16px);
            border-radius: 16px;
            padding: 2.5rem 2rem;
            width: 100%;
            max-width: 600px;
            color: #fff;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            overflow-y: auto;
            max-height: 95vh;
        }

        h2 {
            text-align: center;
            font-size: 2rem;
            background: linear-gradient(to right, #fd79a8, #e17055);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1.8rem;
        }

        label {
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
        }

        input, select, textarea {
            width: 100%;
            padding: 0.8rem;
            margin-bottom: 1.2rem;
            border: none;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.95);
            font-size: 1rem;
            color: #333;
        }

        textarea { resize: vertical; }

        input:focus, select:focus, textarea:focus {
            outline: none;
            box-shadow: 0 0 4px #e17055;
        }

        .btn {
            width: 100%;
            padding: 0.9rem;
            background: #e17055;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #d35400;
        }

        .switch-link {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .switch-link a {
            color: #fab1a0;
            text-decoration: none;
        }

        .switch-link a:hover {
            text-decoration: underline;
        }

        .message-box {
            background: rgba(255,255,255,0.9);
            color: #11d13e;
            padding: 10px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 1rem;
            font-weight: bold;
            transition: opacity 0.5s ease;
        }
    </style>
</head>
<body>
<div class="overlay"></div>
<div class="register-container">
    <h2>📝 Create Your E-Shop Account</h2>

    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
        <div class="message-box"><%= msg %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
    <label>Register as</label>
    <select name="role" id="roleSelect" required>
        <option value="user">User</option>
        <option value="admin">Admin</option>
    </select>

    <!-- Security PIN (only shows if Admin selected) -->
    <div id="pinDiv" style="display:none;">
        <label>Admin Security PIN</label>
        <input type="password" name="pin" placeholder="Enter admin PIN" maxlength="4">
    </div>

    <label>Full Name</label>
    <input type="text" name="name" required placeholder="Enter your name">

    <label>Email</label>
    <input type="email" name="email" required placeholder="Enter your email">

    <label>Phone</label>
    <input type="text" name="phone" required placeholder="Enter your phone number">

    <label>Gender</label>
    <select name="gender" required>
        <option value="">-- Select Gender --</option>
        <option value="male">Male</option>
        <option value="female">Female</option>
    </select>

    <label>Address</label>
    <textarea name="address" rows="3" required placeholder="Enter your address"></textarea>

    <label>Password</label>
    <input type="password" name="password" required placeholder="Enter your password">

    <label>Confirm Password</label>
    <input type="password" name="confirm_password" required placeholder="Enter the password again">

    <label>Security Question</label>
    <input type="text" name="security_question" placeholder="e.g. What’s your pet’s name?" required>

    <button class="btn" type="submit">Register</button>
</form>

<script>
    // Show PIN field only when Admin selected
    const roleSelect = document.getElementById('roleSelect');
    const pinDiv = document.getElementById('pinDiv');
    roleSelect.addEventListener('change', function() {
        pinDiv.style.display = this.value === 'admin' ? 'block' : 'none';
    });

    // Hide message box after 2s
    const msgBox = document.querySelector('.message-box');
    if (msgBox) {
        setTimeout(() => {
            msgBox.style.opacity = '0';
            setTimeout(() => msgBox.style.display = 'none', 500);
        }, 2000);
    }
</script>



    <div class="switch-link">
        <p>Already registered? <a href="login.jsp">Login here</a></p>
    </div>
</div>
</body>
</html>
