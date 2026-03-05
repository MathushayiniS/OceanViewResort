<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Customer Register – Ocean View Resort</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                body {
                    justify-content: center;
                    align-items: center;
                    background: url('https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&q=80&w=1920') no-repeat center center/cover;
                }

                .overlay {
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: linear-gradient(135deg, rgba(6, 78, 59, 0.85) 0%, rgba(8, 47, 73, 0.75) 100%);
                    z-index: -1;
                }

                .register-container {
                    max-width: 460px;
                    width: 100%;
                    margin: auto;
                }

                .register-header {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .register-header h1 {
                    font-size: 2rem;
                    color: white;
                    margin-bottom: 0.3rem;
                }

                .register-header p {
                    color: #6ee7b7;
                    font-weight: 300;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    font-size: 0.85rem;
                }

                .form-row {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 1rem;
                }

                @media (max-width: 480px) {
                    .form-row {
                        grid-template-columns: 1fr;
                    }
                }
            </style>
        </head>

        <body>
            <div class="overlay"></div>
            <div class="main-content" style="padding: 2rem; max-width: 1200px; margin: 0 auto; width: 100%;">
                <div class="register-container glass-container animate-fade-in">
                    <div class="register-header">
                        <h1><i class="fa-solid fa-water"></i> Ocean View</h1>
                        <p>Create Customer Account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <i class="fa-solid fa-circle-exclamation"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/customer-auth" method="post">
                        <input type="hidden" name="action" value="register">

                        <div class="form-group">
                            <label for="fullName"><i class="fa-solid fa-user"></i> Full Name</label>
                            <input type="text" id="fullName" name="fullName" class="form-control" required
                                placeholder="Enter your full name">
                        </div>

                        <div class="form-group">
                            <label for="email"><i class="fa-solid fa-envelope"></i> Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" required
                                placeholder="Enter your email address">
                        </div>

                        <div class="form-group">
                            <label for="phone"><i class="fa-solid fa-phone"></i> Phone Number</label>
                            <input type="tel" id="phone" name="phone" class="form-control" required
                                placeholder="Enter your phone number">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="password"><i class="fa-solid fa-lock"></i> Password</label>
                                <input type="password" id="password" name="password" class="form-control" required
                                    placeholder="Create password" minlength="6">
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword"><i class="fa-solid fa-lock"></i> Confirm</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                                    required placeholder="Confirm password" minlength="6">
                            </div>
                        </div>

                        <div id="pwMatchMsg"
                            style="font-size: 0.8rem; margin-top: -0.5rem; margin-bottom: 1rem; display: none;"></div>

                        <button type="submit" id="submitBtn" class="btn btn-primary"
                            style="width: 100%; margin-top: 0.5rem; background: linear-gradient(135deg, #10b981, #059669);">
                            Create Account <i class="fa-solid fa-user-plus" style="margin-left: 0.5rem;"></i>
                        </button>
                    </form>

                    <div style="text-align: center; margin-top: 1.5rem; color: var(--text-muted); font-size: 0.9rem;">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/customer-login.jsp"
                            style="color: #6ee7b7; text-decoration: none; margin-left: 0.3rem;">
                            Login here
                        </a>
                    </div>
                </div>
            </div>

            <script>
                const pwd = document.getElementById('password');
                const cpwd = document.getElementById('confirmPassword');
                const msg = document.getElementById('pwMatchMsg');

                function checkMatch() {
                    if (cpwd.value.length === 0) { msg.style.display = 'none'; return; }
                    msg.style.display = 'block';
                    if (pwd.value === cpwd.value) {
                        msg.style.color = '#10b981';
                        msg.innerHTML = '<i class="fa-solid fa-check"></i> Passwords match';
                    } else {
                        msg.style.color = '#ef4444';
                        msg.innerHTML = '<i class="fa-solid fa-xmark"></i> Passwords do not match';
                    }
                }
                pwd.addEventListener('input', checkMatch);
                cpwd.addEventListener('input', checkMatch);
            </script>
        </body>

        </html>