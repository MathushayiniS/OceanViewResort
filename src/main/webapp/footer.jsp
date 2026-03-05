</div> <!-- End of main-content -->

<footer
    style="text-align: center; padding: 2rem; color: var(--text-muted); margin-top: auto; border-top: 1px solid var(--glass-border); font-size: 0.9rem;">
    &copy; <%= java.time.Year.now().getValue() %> Ocean View Resort. All rights reserved. <br>
        <small>Strictly Confidential - Internal System</small>
</footer>

<%-- Only load JS if not on login page --%>
    <c:if test="${not empty sessionScope.user}">
        <script src="${pageContext.request.contextPath}/js/app.js"></script>
    </c:if>
    </body>

    </html>