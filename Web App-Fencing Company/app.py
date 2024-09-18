from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL
import database.db_connector as db
import os
import logging

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_loyami'
app.config['MYSQL_PASSWORD'] = '8319' #last 4 of onid
app.config['MYSQL_DB'] = 'cs340_loyami'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"


mysql = MySQL(app)

# Routes
@app.route('/')
def root():
    return render_template("index.html")

# CUSTOMERS (SELECT, INSERT, DELETE)
@app.route('/customers', methods=["POST", "GET"])
def customers():
    if request.method == "GET":
        query = "SELECT * FROM Customers;"
        cur = mysql.connection.cursor()
        cur.execute(query)
        results = cur.fetchall()
        return render_template("customers.html", customers=results)

    if request.method == "POST":
        if request.form.get("Add Customer"):
            # Get form data
            name = request.form['name']
            phone = request.form['phone']
            email = request.form['email']
            address = request.form['address']
            previousPurchases = request.form['previousPurchases']

            # Add customer to database (insert your own SQL query here)
            query = "INSERT INTO Customers (Name, Phone, Email, Address, PreviousPurchases) VALUES (%s, %s, %s, %s, %s)"
            cur = mysql.connection.cursor()
            
            logging.info(f"Inserting data: {name, phone, email, address, previousPurchases}")
            
            try:
                cur.execute(query, (name, phone, email, address, previousPurchases))
                mysql.connection.commit()
                logging.info("Data inserted successfully")
            except Exception as e:
                logging.error(f"Failed to insert data: {e}")
                        
            # Redirect to customers page
        return redirect('/customers')

@app.route('/customers/delete', methods=['POST'])
def delete_customer():
    try:
        CustomerID = request.form['CustomerID']
        query = "DELETE FROM Customers WHERE CustomerID = %s"
        cur = mysql.connection.cursor()
        cur.execute(query, (CustomerID,))
        mysql.connection.commit()
        return redirect('/customers')
    except KeyError:
        return "CustomerID not found in the submitted form. Form data: " + str(request.form)

# SALESMEN (SELECT, INSERT, DELETE)
@app.route('/salesmen', methods=["POST", "GET"])
def salesmen():
    if request.method == "POST":
        # Get form data
        name = request.form['name']
        numberOfSales = request.form['numberOfSales']
        rating = request.form['rating']

        # Insert into Salesmen
        query = "INSERT INTO Salesmen (Name, NumberOfSales, Rating) VALUES (%s, %s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (name, numberOfSales, rating))
        mysql.connection.commit()

    query = "SELECT * FROM Salesmen;"
    cur = mysql.connection.cursor()
    cur.execute(query)
    results = cur.fetchall()
    return render_template("salesmen.html", salesmen=results)

@app.route('/salesmen/delete', methods=['POST'])
def delete_salesman():
    try:
        SalesmanID = request.form['SalesmanID']
        query = "DELETE FROM Salesmen WHERE SalesmanID = %s"
        cur = mysql.connection.cursor()
        cur.execute(query, (SalesmanID,))
        mysql.connection.commit()
        return redirect('/salesmen')
    except KeyError:
        return "SalesmanID not found in the submitted form. Form data: " + str(request.form)

# CONTRACTORS (SELECT, INSERT, DELETE)
@app.route('/contractors', methods=["POST", "GET"])
def contractors():
    if request.method == "POST":
        # Get form data
        companyName = request.form['companyName']
        phone = request.form['phone']
        email = request.form['email']
        rating = request.form['rating']
        totalJobsCompleted = request.form['totalJobsCompleted']

        # Insert into Contractors
        query = "INSERT INTO Contractors (CompanyName, Phone, Email, Rating, TotalJobsCompleted) VALUES (%s, %s, %s, %s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (companyName, phone, email, rating, totalJobsCompleted))
        mysql.connection.commit()

    query = "SELECT * FROM Contractors ;"
    cur = mysql.connection.cursor()
    cur.execute(query)
    results = cur.fetchall()
    return render_template("contractors.html", contractors=results)

@app.route('/contractors/delete', methods=['POST'])
def delete_contractor():
    try:
        ContractorID = request.form['ContractorID']
        query = "DELETE FROM Contractors WHERE ContractorID = %s"
        cur = mysql.connection.cursor()
        cur.execute(query, (ContractorID,))
        mysql.connection.commit()
        return redirect('/contractors')
    except KeyError:
        return "ContractorID not found in the submitted form. Form data: " + str(request.form)

# INVOICES (SELECT, INSERT, DELETE, UPDATE)
@app.route('/invoices', methods=["POST", "GET"])
def invoices():
    cursor = mysql.connection.cursor()

    if request.method == 'POST':
        customerID = request.form.get('customerID')
        salesmanID = request.form.get('salesmanID')
        contractorID = request.form.get('contractorID')
        invoiceDate = request.form.get('invoiceDate')
        totalDue = request.form.get('totalDue')

        if contractorID == '':
            contractorID = None

        query = "INSERT INTO Invoices (CustomerID, SalesmanID, ContractorID, InvoiceDate, TotalDue) VALUES (%s, %s, %s, %s, %s);"
        cursor.execute(query, (customerID, salesmanID, contractorID, invoiceDate, totalDue))
        mysql.connection.commit()

    # Invoices with legible Customer, Salesman and Contractor info
    query = """
    SELECT 
        i.InvoiceID,
        c.Name AS CustomerName,
        s.Name AS SalesmanName,
        co.CompanyName AS ContractorName,
        i.InvoiceDate,
        COALESCE(SUM(id.LineTotal), 0) AS TotalDue
    FROM 
        Invoices i
    JOIN 
        Customers c ON i.CustomerID = c.CustomerID
    JOIN 
        Salesmen s ON i.SalesmanID = s.SalesmanID
    LEFT JOIN 
        Contractors co ON i.ContractorID = co.ContractorID
    LEFT JOIN 
        InvoiceDetails id ON i.InvoiceID = id.InvoiceID
    GROUP BY 
        i.InvoiceID,
        c.Name,
        s.Name,
        co.CompanyName,
        i.InvoiceDate;
    """
    cursor.execute(query)
    invoices = cursor.fetchall()

    # Additional fetches for dropdowns
    cursor.execute("SELECT * FROM Customers;")
    customers = cursor.fetchall()

    cursor.execute("SELECT * FROM Salesmen;")
    salesmen = cursor.fetchall()

    cursor.execute("SELECT * FROM Contractors;")
    contractors = cursor.fetchall()    

    cursor.close()

    return render_template("invoices.html", invoices=invoices, customers=customers, salesmen=salesmen, contractors=contractors)

@app.route('/invoices/delete', methods=['POST'])
def delete_invoice():
    InvoiceID = request.form['InvoiceID']
    query = "DELETE FROM Invoices WHERE InvoiceID = %s"
    cur = mysql.connection.cursor()
    cur.execute(query, (InvoiceID,))
    mysql.connection.commit()
    return redirect('/invoices')

@app.route('/update_invoice/<int:id>', methods=["POST", "GET"])
def update_invoice(id):
    cursor = mysql.connection.cursor()

    if request.method == 'POST':
        customerID = request.form.get('customerID')
        salesmanID = request.form.get('salesmanID')
        contractorID = request.form.get('contractorID')
        invoiceDate = request.form.get('invoiceDate')
        totalDue = request.form.get('totalDue')

        if contractorID == '':
            contractorID = None

        query = """UPDATE Invoices
                    SET CustomerID=%s, SalesmanID=%s, ContractorID=%s, InvoiceDate=%s, TotalDue=%s
                    WHERE InvoiceID=%s;"""
        cursor.execute(query, (customerID, salesmanID, contractorID, invoiceDate, totalDue, id))
        mysql.connection.commit()

        return redirect('/invoices')

    query = "SELECT * FROM Invoices WHERE InvoiceID=%s;"
    cursor.execute(query, (id,))
    invoice = cursor.fetchone()

    cursor.execute("SELECT * FROM Customers;")
    customers = cursor.fetchall()

    cursor.execute("SELECT * FROM Salesmen;")
    salesmen = cursor.fetchall()

    cursor.execute("SELECT * FROM Contractors;")
    contractors = cursor.fetchall()

    cursor.close()

    if not invoice:
        return "Invoice not found", 404

    return render_template('update_invoice.html', invoice=invoice, customers=customers, salesmen=salesmen, contractors=contractors)

# FENCES (SELECT, INSERT, DELETE)
@app.route('/fences', methods=["POST", "GET"])
def fences():
    if request.method == "POST":
        # Get form data
        description = request.form['description']
        listPricePerMeter = request.form['listPricePerMeter']

        # Insert into Fences
        query = "INSERT INTO Fences (Description, ListPricePerMeter) VALUES (%s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (description, listPricePerMeter))
        mysql.connection.commit()

    query = "SELECT * FROM Fences;"
    cur = mysql.connection.cursor()
    cur.execute(query)
    results = cur.fetchall()
    return render_template("fences.html", fences=results)

@app.route('/fences/delete', methods=['POST'])
def delete_fence():
    FenceID = request.form['FenceID']
    query = "DELETE FROM Fences WHERE FenceID = %s"
    cur = mysql.connection.cursor()
    cur.execute(query, (FenceID,))
    mysql.connection.commit()
    return redirect('/fences')

# INVOICE DETAILS (SELECT, INSERT, DELETE)
@app.route('/InvoiceDetails', methods=["POST", "GET"])
def invoice_details():
    cur = mysql.connection.cursor()

    if request.method == "POST":
        # Get form data
        invoiceID = request.form['invoiceID']
        fenceID = request.form['fenceID']
        metersOrdered = float(request.form['metersOrdered'])  # Convert to float
        
        # Fetch the unit price for the selected fence
        cur.execute("SELECT ListPricePerMeter FROM Fences WHERE FenceID = %s", (fenceID,))
        fence = cur.fetchone()
        if not fence:
            return "Fence not found", 404

        unitPricePerMeter = float(fence['ListPricePerMeter'])
        
        # Calculate LineTotal
        lineTotal = metersOrdered * unitPricePerMeter

        # Insert into InvoiceDetails
        query = """
        INSERT INTO InvoiceDetails (InvoiceID, FenceID, MetersOrdered, UnitPricePerMeter, LineTotal) 
        VALUES (%s, %s, %s, %s, %s)
        """
        cur.execute(query, (invoiceID, fenceID, metersOrdered, unitPricePerMeter, lineTotal))
        mysql.connection.commit()

    # Fetching invoice details with Fence Description
    query = """
    SELECT 
        InvoiceDetails.InvoiceDetailsID, InvoiceDetails.InvoiceID, InvoiceDetails.FenceID, 
        Fences.Description, InvoiceDetails.MetersOrdered, Fences.ListPricePerMeter AS UnitPricePerMeter, 
        InvoiceDetails.LineTotal
    FROM InvoiceDetails
    LEFT JOIN Fences ON InvoiceDetails.FenceID = Fences.FenceID
    """
    cur.execute(query)
    invoice_details_data = cur.fetchall()

    # Fetching all invoices and fences for the form dropdowns
    cur.execute("SELECT InvoiceID FROM Invoices")
    invoices = cur.fetchall()

    cur.execute("SELECT FenceID, Description FROM Fences")
    fences = cur.fetchall()

    cur.close()

    return render_template('InvoiceDetails.html', invoice_details=invoice_details_data, invoices=invoices, fences=fences)

@app.route('/invoiceDetails/delete', methods=['POST'])
def delete_invoiceDetails():
    InvoiceDetailsID = request.form['InvoiceDetailsID']
    query = "DELETE FROM InvoiceDetails WHERE InvoiceDetailsID = %s"
    cur = mysql.connection.cursor()
    cur.execute(query, (InvoiceDetailsID,))
    mysql.connection.commit()
    return redirect('/InvoiceDetails')

# Listener
if __name__ == "__main__":
    #Start the app on port 6789, it will be different once hosted
    app.run(port=6789, debug=True)
