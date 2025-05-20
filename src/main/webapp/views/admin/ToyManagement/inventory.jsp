<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.toyStore.model.Toymanagement.Toy" %>
<%
    String message = (String) request.getAttribute("message");
    List<Toy> toys = (List<Toy>) request.getAttribute("toys");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Toy Inventory</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(120deg, #f9fafb 0%, #f6f0f0 60%, #fd79a8 100%);
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
            color: #2d3436;
            min-height: 100vh;
        }
        .inventory-glass {
            background: rgba(255,255,255,0.93);
            border-radius: 28px;
            box-shadow: 0 12px 48px rgba(108,92,231,0.13);
            padding: 2.5rem 2rem 2.5rem 2rem;
            max-width: 1200px;
            margin: 4rem auto 2rem auto;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1.5px solid rgba(108,92,231,0.09);
        }
        .inventory-title {
            color: #6c5ce7;
            font-weight: 800;
            font-size: 2.2rem;
            letter-spacing: 0.03em;
            margin-bottom: 0.5em;
        }
        .btn-back {
            background: none;
            color: #6c5ce7;
            border: 2px solid #6c5ce7;
            font-weight: 700;
            border-radius: 10px;
            padding: 0.5em 1.3em;
            transition: background 0.2s, color 0.2s;
        }
        .btn-back:hover {
            background: #6c5ce7;
            color: #fff;
        }
        .form-label {
            color: #636e72;
            font-weight: 600;
        }
        .form-control, .form-control:focus {
            border-radius: 10px;
            border-color: #6c5ce7;
            box-shadow: 0 0 0 0.13rem rgba(108, 92, 231, 0.08);
        }
        .table {
            background: #fff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 4px 18px rgba(108,92,231,0.08);
        }
        .table thead {
            background: #6c5ce7;
            color: #fff;
            font-size: 1.07rem;
            letter-spacing: 0.01em;
        }
        .table tbody tr:hover {
            background: #f1f3f6;
        }
        .btn-primary, .btn-danger {
            font-weight: 700;
            border-radius: 10px;
        }
        .btn-primary {
            background: linear-gradient(90deg, #6c5ce7 0%, #fd79a8 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #fd79a8 0%, #6c5ce7 100%);
        }
        .btn-danger {
            background: #fd5e53;
            border: none;
        }
        .btn-danger:hover {
            background: #c0392b;
        }
        .badge-age {
            background: #fd79a8;
            color: #fff;
            font-size: 0.98em;
            border-radius: 8px;
            padding: 0.32em 0.9em;
        }
        @media (max-width: 991px) {
            .inventory-glass { padding: 1.2rem 0.5rem; }
            .table-responsive { font-size: 0.98em; }
        }
        @media (max-width: 767px) {
            .inventory-title { font-size: 1.4rem; }
            .table th, .table td { font-size: 0.96em; }
        }
    </style>
</head>
<body>

<%@ include file="/views/header.jsp" %>

<div class="inventory-glass">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="inventory-title"><i class="fas fa-cubes me-2"></i>Toy Inventory Management</h2>
        <a href="${pageContext.request.contextPath}/views/admin/AdminManagement/adminDashboard.jsp" class="btn btn-back">
            <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
        </a>
    </div>

    <% if (message != null) { %>
    <div class="alert alert-info"><%= message %></div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/views/admin/toyManagement" class="mb-5" enctype="multipart/form-data">
        <div class="row g-3 align-items-end">
            <div class="col-md-2">
                <label for="id" class="form-label">Toy ID</label>
                <input type="number" class="form-control" id="id" name="id" required />
            </div>
            <div class="col-md-2">
                <label for="name" class="form-label">Toy Name</label>
                <input type="text" class="form-control" id="name" name="name" required />
            </div>
            <div class="col-md-2">
                <label for="description" class="form-label">Description</label>
                <input type="text" class="form-control" id="description" name="description" required />
            </div>
            <div class="col-md-2">
                <label for="ageGroup" class="form-label">Age Group</label>
                <input type="number" class="form-control" id="ageGroup" name="ageGroup" min="0" required />
            </div>
            <div class="col-md-2">
                <label for="price" class="form-label">Price (Rs)</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price" min="0" required />
            </div>
            <div class="col-md-2">
                <label for="image" class="form-label">Image</label>
                <input type="file" class="form-control" id="image" name="image" accept="image/*" required />
            </div>
            <div class="col-md-12 mt-3">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-plus me-2"></i>Add Toy
                </button>
            </div>
        </div>
    </form>

    <h4 class="mb-3" style="color:#fd79a8;font-weight:700;"><i class="fas fa-list me-2"></i>Current Toys</h4>
    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>Toy ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Age Group</th>
                <th>Price (Rs)</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% if (toys != null && !toys.isEmpty()) {
                for (Toy toy : toys) { %>
            <tr>
                <td><%= toy.getId() %></td>
                <td><%= toy.getName() %></td>
                <td><%= toy.getDescription() %></td>
                <td><span class="badge badge-age"><%= toy.getAgeGroup() %>+</span></td>
                <td>Rs <%= String.format("%.2f", toy.getPrice()) %></td>
                <td>
                    <%
                        String imagePath = toy.getImagePath();
                        if (imagePath != null && !imagePath.isEmpty()) {
                    %>
                    <img src="<%= request.getContextPath() + "/" + imagePath %>" alt="Toy Image" style="width: 80px; height: 80px; object-fit: cover; border-radius: 10px; box-shadow: 0 2px 8px #fd79a8;">
                    <%
                    } else {
                    %>
                    <span class="text-muted">No image</span>
                    <%
                        }
                    %>
                </td>
                <td>
                    <form method="post" action="${pageContext.request.contextPath}/views/admin/toyManagement" style="display:inline;">
                        <input type="hidden" name="id" value="<%= toy.getId() %>" />
                        <input type="hidden" name="action" value="remove" />
                        <button type="submit" class="btn btn-danger btn-sm"
                                onclick="return confirm('Remove this toy?');">
                            <i class="fas fa-trash-alt"></i> Remove
                        </button>
                    </form>
                </td>
            </tr>
            <%  }
            } else { %>
            <tr>
                <td colspan="7" class="text-center text-muted">No toys in inventory.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
