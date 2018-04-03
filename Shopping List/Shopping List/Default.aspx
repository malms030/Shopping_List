<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Login</title>
     <link rel="stylesheet" type="text/css" href="Login.css"/>
</head>
<body>
    <div id="loginDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin">
            <b id="loginTitle">Shopping List</b>
            <br />
                    <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
            <span id="spanUid">Username</span>
            <br />
            <asp:TextBox runat="server" ID="Uid" placeholder="Enter Username" required="required" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanPwd">Password</span>
            <br />
            <asp:TextBox runat="server" ID="UPwd" placeholder="Enter Password" required="required" CssClass="Textbox" />
            <br />
            <br />
            <asp:Button runat="server" ID="loginButton" Text="Log In" />
            <br />
            <br />
            <br />
            <span>Not a registered user? </span>
            <asp:LinkButton runat="server" ID="createAccountButton" Text="Create an Account" PostBackUrl="createAccount.aspx" />
        </asp:label>
    </form>
    </div>

</body>
</html>