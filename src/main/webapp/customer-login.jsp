<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Customer Login – Ocean View Resort</title>
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

                .login-container {
                    max-width: 420px;
                    width: 100%;
                    margin: auto;
                }

                .login-header {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .login-header h1 {
                    font-size: 2.2rem;
                    color: white;
                    margin-bottom: 0.3rem;
                }

                .login-header p {
                    color: #6ee7b7;
                    font-weight: 300;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                    font-size: 0.85rem;
                }

                .portal-badge {
                    display: inline-block;
                    background: linear-gradient(135deg, #10b981, #059669);
                    color: white;
                    padding: 0.3rem 1rem;
                    border-radius: 20px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    margin-bottom: 1rem;
                }

                .staff-link {
                    text-align: center;
                    margin-top: 1.2rem;
                    color: var(--text-muted);
                    font-size: 0.85rem;
                }

                .staff-link a {
                    color: #6ee7b7;
                    text-decoration: none;
                }

                .staff-link a:hover {
                    text-decoration: underline;
                }
            </style>
        </head>

        <body>
            <div class="overlay"></div>
            <div class="main-content" style="padding: 2rem; max-width: 1200px; margin: 0 auto; width: 100%;">
                <div class="login-container glass-container animate-fade-in">
                    <div class="login-header">
                        <h1><i class="fa-solid fa-water"></i> Ocean View</h1>
                        <p>Resort Booking System</p>
                        <span class="portal-badge"><i class="fa-solid fa-user"></i> Customer Portal</span>
                    </div>

                    <c:if test="${param.registered == 1}">
                        <div class="alert alert-success">
                            <i class="fa-solid fa-circle-check"></i> Account created! Please login to continue.
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <i class="fa-solid fa-circle-exclamation"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/customer-auth" method="post">
                        <input type="hidden" name="action" value="login">

                        <div class="form-group">
                            <label for="email"><i class="fa-solid fa-envelope"></i> Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" required
                                placeholder="Enter your email address">
                        </div>

                        <div class="form-group" style="margin-bottom: 2rem;">
                            <label for="password"><i class="fa-solid fa-lock"></i> Password</label>
                            <input type="password" id="password" name="password" class="form-control" required
                                placeholder="Enter your password">
                        </div>

                        <button type="submit" class="btn btn-primary"
                            style="width: 100%; background: linear-gradient(135deg, #10b981, #059669);">
                            Login to Customer Portal <i class="fa-solid fa-arrow-right-to-bracket"
                                style="margin-left: 0.5rem;"></i>
                        </button>
                    </form>

                    <div
                        style="text-align: center; margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid rgba(255,255,255,0.1);">
                        <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 0.8rem;">
                            Don't have an account?
                        </p>
                        <a href="${pageContext.request.contextPath}/customer-register.jsp" class="btn btn-accent"
                            style="width: 100%;">
                            <i class="fa-solid fa-user-plus"></i> Create New Account
                        </a>
                    </div>

                    <div class="staff-link">
                        Staff / Admin? <a href="${pageContext.request.contextPath}/login.jsp">Login here</a>
                    </div>

                    <div style="text-align: center; margin-top: 1.5rem; color: var(--text-muted); font-size: 0.85rem;">
                        <i class="fa-solid fa-shield-halved"></i> 256-bit Encrypted Connection
                    </div>
                </div>
            </div>
        </body>

        </html>