<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Create Account</title>
     <link rel="stylesheet" type="text/css" href="Login.css"/>
</head>
<body>
    <div id="createAccDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin">
            <b id="loginTitle">Create an Account</b>
            <br />
                    <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
            <span id="spanUid">Create a Username</span>
            <br />
            <asp:TextBox runat="server" ID="createUid" placeholder="Enter Username" required="required" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanPwd">Create a Password</span>
            <br />
            <asp:TextBox runat="server" ID="createUPwd" placeholder="Enter Password" required="required" CssClass="Textbox" />
            <br />
            <br />
            <asp:Button runat="server" ID="createButton" Text="Create Account" />
            <br />
            <br />
            <br />
            <span>Already a registered user? </span>
            <asp:LinkButton runat="server" ID="logInButton" Text="Login" PostBackUrl="Default.aspx"/>
        </asp:label>
    </form>
    </div>

</body>
</html>