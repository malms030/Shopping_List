<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    public void submitButton_Click (object sender, EventArgs e)
    {

    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Submit a Help Request</title>
     <link rel="stylesheet" type="text/css" href="css/submitRequest.css"/>
</head>
<body>
    <div id="requestDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin">
            <b id="requestTitle">Shopping List</b>
            <br />
                    <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
            <span id="spanSubject">Subject</span>
            <br />
            <asp:TextBox runat="server" ID="Subject" placeholder="Request Subject" required="required" CssClass="subject" />
            <br />
            <br />
            <span id="spanContent">Request</span>
            <br />
            <asp:TextBox runat="server" ID="Content" required="required" CssClass="content" />
            <br />
            <asp:Button runat="server" ID="reqSubmitButton" OnClick="submitButton_Click" Text="Submit" />
            <br />
            <br />
            <br />
            <span></span>
            <asp:LinkButton runat="server" ID="listDirectButton" Text="Back to List" PostBackUrl="List.aspx" />
        </asp:label>
    </form>
    </div>

</body>
</html>