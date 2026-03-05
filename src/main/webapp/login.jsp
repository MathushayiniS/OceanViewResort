<jsp:include page="header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.9) 0%, rgba(8, 47, 73, 0.7) 100%);
            z-index: -1;
        }

        .login-container {
            max-width: 400px;
            width: 100%;
            margin: auto;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h1 {
            font-size: 2.5rem;
            color: white;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: var(--accent-color);
            font-weight: 300;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
    </style>

    <div class="overlay"></div>

    <div class="login-container glass-container animate-fade-in">
        <div class="login-header">
            <h1>Ocean View</h1>
            <p>Resort Booking System</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="login">

            <div class="form-group" style="text-align: center; margin-bottom: 1.5rem;">
                <label style="margin-bottom: 0.8rem;"><i class="fa-solid fa-users-gear"></i> Select Account Type</label>
                <div style="display: flex; gap: 1rem; justify-content: center;">
                    <label style="flex: 1; cursor: pointer;">
                        <input type="radio" name="role" value="Admin" required style="display: none;" id="roleAdmin"
                            checked>
                        <div class="role-card"
                            style="padding: 1rem; border: 2px solid var(--secondary-color); border-radius: 8px; transition: all 0.3s;"
                            id="cardAdmin">
                            <i class="fa-solid fa-user-shield"
                                style="font-size: 1.5rem; color: var(--secondary-color); margin-bottom: 0.5rem; display:block;"></i>
                            <strong>Admin</strong>
                        </div>
                    </label>
                    <label style="flex: 1; cursor: pointer;">
                        <input type="radio" name="role" value="Staff" required style="display: none;" id="roleStaff">
                        <div class="role-card"
                            style="padding: 1rem; border: 2px solid transparent; border-radius: 8px; transition: all 0.3s; background: rgba(255,255,255,0.05);"
                            id="cardStaff">
                            <i class="fa-solid fa-user-tie"
                                style="font-size: 1.5rem; color: var(--text-muted); margin-bottom: 0.5rem; display:block;"></i>
                            <strong>Staff</strong>
                        </div>
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label for="username"><i class="fa-solid fa-user"></i> Username</label>
                <input type="text" id="username" name="username" class="form-control" required
                    placeholder="Enter your username">
            </div>

            <div class="form-group" style="margin-bottom: 2rem;">
                <label for="password"><i class="fa-solid fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" class="form-control" required
                    placeholder="Enter hashed password">
            </div>

            <script>
                // Add simple Javascript to toggle the selected border styling
                const adminInput = document.getElementById('roleAdmin');
                const staffInput = document.getElementById('roleStaff');
                const cardAdmin = document.getElementById('cardAdmin');
                const cardStaff = document.getElementById('cardStaff');

                adminInput.addEventListener('change', () => {
                    if (adminInput.checked) {
                        cardAdmin.style.borderColor = 'var(--secondary-color)';
                        cardAdmin.style.background = 'transparent';
                        cardAdmin.querySelector('i').style.color = 'var(--secondary-color)';

                        cardStaff.style.borderColor = 'transparent';
                        cardStaff.style.background = 'rgba(255,255,255,0.05)';
                        cardStaff.querySelector('i').style.color = 'var(--text-muted)';
                    }
                });

                staffInput.addEventListener('change', () => {
                    if (staffInput.checked) {
                        cardStaff.style.borderColor = 'var(--secondary-color)';
                        cardStaff.style.background = 'transparent';
                        cardStaff.querySelector('i').style.color = 'var(--secondary-color)';

                        cardAdmin.style.borderColor = 'transparent';
                        cardAdmin.style.background = 'rgba(255,255,255,0.05)';
                        cardAdmin.querySelector('i').style.color = 'var(--text-muted)';
                    }
                });
            </script>

            <button type="submit" class="btn btn-primary" style="width: 100%;">
                Secure Login <i class="fa-solid fa-arrow-right-to-bracket" style="margin-left: 0.5rem;"></i>
            </button>
        </form>

        <div style="text-align: center; margin-top: 1.5rem; color: var(--text-muted); font-size: 0.85rem;">
            <i class="fa-solid fa-shield-halved"></i> 256-bit Encrypted Connection
        </div>

        <div
            style="text-align: center; margin-top: 1.2rem; padding-top: 1.2rem; border-top: 1px solid rgba(255,255,255,0.1); font-size: 0.85rem; color: var(--text-muted);">
            Customer? <a href="${pageContext.request.contextPath}/customer-login.jsp"
                style="color: var(--accent-color); text-decoration: none;">Login to Customer Portal</a>
        </div>
    </div>

    <jsp:include page="footer.jsp" />