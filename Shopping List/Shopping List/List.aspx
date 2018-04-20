<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    public string userid;


    protected void removeBtn_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in grdItems.Rows)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string userid = Request.Cookies["UserID"].Value;
                    System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                    string sqlremove = "DELETE FROM list_items WHERE id = @id AND item_name = @name;";
                    string sqladdrecent = "insert into recent_items (id, item_name, description) values (@id, @name, @notes)";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlremove, sqlConnStr);
                    System.Data.SqlClient.SqlCommand cmd2 = new System.Data.SqlClient.SqlCommand(sqladdrecent, sqlConnStr);
                    cmd.Parameters.Add("@id", System.Data.SqlDbType.Int);
                    cmd.Parameters["@id"].Value = userid;
                    cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar, 100);
                    cmd.Parameters["@name"].Value = row.Cells[1].Text;
                    cmd2.Parameters.AddWithValue("@id",userid);
                    cmd2.Parameters.AddWithValue("@name", row.Cells[1].Text);
                    cmd2.Parameters.AddWithValue("@notes", row.Cells[5].Text);
                    cmd2.Connection.Open();
                    cmd2.ExecuteNonQuery();
                    cmd2.Connection.Close();
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                    Response.Redirect("List.aspx");

                }
            }
        }
        catch(System.Data.SqlClient.SqlException ex)
        {

        }
    }
    protected void addBtn_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if ((item.Text == "") || (qty.Text == ""))
            {
                item.BorderColor = System.Drawing.Color.Red;
                qty.BorderColor = System.Drawing.Color.Red;
            }
            else
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlinsert = "insert into list_items (id, item_name, qty, store, dept, description) values (@id, @item, @qty, @store, @dept, @notes)";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
                cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
                cmd.Parameters.Add("@item", System.Data.SqlDbType.VarChar, 100);
                cmd.Parameters["@item"].Value = item.Text;
                cmd.Parameters.Add("@qty", System.Data.SqlDbType.Int);
                cmd.Parameters["@qty"].Value = qty.Text;
                cmd.Parameters.Add("@store", System.Data.SqlDbType.VarChar, 100);
                cmd.Parameters["@store"].Value = store.Text;
                cmd.Parameters.Add("@dept", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@dept"].Value = dept.Text;
                cmd.Parameters.Add("@notes", System.Data.SqlDbType.VarChar, 500);
                cmd.Parameters["@notes"].Value = notes.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("List.aspx");
                cmd.Connection.Close();
            }
        }
        catch(System.FormatException ex) {
            item.BorderColor = System.Drawing.Color.Red;
            qty.BorderColor = System.Drawing.Color.Red;}


    }

    public void freqaddBtn_Click(object o, EventArgs e)
    {
        if (addfreq.Text == "")
        {
            addfreq.BorderColor = System.Drawing.Color.Red;
        }
        else
        {
            try
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlinsert = "insert into freq_item (id, item_name, description) values (@id, @item, @description)";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
                cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
                cmd.Parameters.AddWithValue("@item", addfreq.Text);
                cmd.Parameters.AddWithValue("@description", freqDesc.Text);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("List.aspx");
                cmd.Connection.Close();
            }
            catch (System.FormatException ex)
            {
                addfreq.BorderColor = System.Drawing.Color.Red;
            }
        }
    }

    public void show_list(object o, EventArgs e)
    {
        form1.Visible = false;
        freqitemsform.Visible = true;
    }

    public void freqItemsRemove(object o, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in freqitems.Rows)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string userid = Request.Cookies["UserID"].Value;
                    System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                    string sqlremove = "DELETE FROM freq_item WHERE id = @id AND item_name = @name;";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlremove, sqlConnStr);
                    cmd.Parameters.Add("@id", System.Data.SqlDbType.Int);
                    cmd.Parameters["@id"].Value = userid;
                    cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar, 100);
                    cmd.Parameters["@name"].Value = row.Cells[1].Text;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                    Response.Redirect("List.aspx");

                }
            }
        }
        catch(System.Data.SqlClient.SqlException ex)
        {

        }
    }

    public void freqItemsUpdate(object o, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
        string sqlupdate = "UPDATE freq_item SET last_purchase_date = GETDATE() WHERE id = @id";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlupdate, sqlConnStr);
        cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
        cmd.Connection.Open();
        cmd.ExecuteNonQuery();
        cmd.Connection.Close();
        Response.Redirect("List.aspx");

    }
    public void recentcancel_Click(object o, EventArgs e)
    {

    }
    public void recentadd_Click(object o, EventArgs e)
    {

    }

    public void SortButton_Click(object o, EventArgs e)
    {
        String expression = "";

    expression = SortList1.SelectedValue + "," + SortList2.SelectedValue;
    grdItems.Sort(expression, SortDirection.Ascending);

  }
    
</script>
<script type="text/javascript">
    function myFunction() {
        document.getElementById("myDropdown").classList.toggle("show");
    }

    function myFunction2() {
        document.getElementById("myDropdown2").classList.toggle("show");
    }

    // Close the dropdown if the user clicks outside of it
    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {

            var dropdowns = document.getElementsByClassName("dropdown-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List</title>
     <link rel="stylesheet" type="text/css" href="css/List.css"/>
    <style>



.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown2 {
    position: absolute;
    padding-left: 358px;
    padding-top: 20px;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: saddlebrown;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: white;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown a:hover {background-color: #FFFAF0; color: black;
}

.show {display:block;}

</style>
</head>
<body>
    <form id="form1" visible="true" runat="server">
        
       <div id="icons">
 
<img id="userBtn" src="Images/usericon.png" class="dropbtn" onclick="myFunction2()" />
<div class="dropdown">
  <div id="myDropdown2" class="dropdown-content">
    <a href="#home">Update User Information</a>
    <a href="#about">Sign Out</a>
  </div>
</div>           


<img id="settingsBtn" src="Images/settings.png" class="dropbtn" onclick="myFunction()" />
<div class="dropdown2">
  <div id="myDropdown" class="dropdown-content">
    <a href="#home">Submit Help Request</a>
    <a href="#about">Prediction On/Off</a>
  </div>
</div>




  
           <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
           <br />

       </div>
        


<div id="container">
        <button class="accordion" type="button">Sorting</button>
        <div id="Sorting" class="panel">
            <b id="sortingTitle">Sorting</b>
            <br />
        <table>
        <tr>
          <td>
             Sort by:
            <asp:dropdownlist ID="SortList1"
              runat="server" CssClass="ddl">
              <asp:listitem>Item</asp:listitem>
              <asp:listitem>QTY</asp:listitem>
              <asp:listitem Selected="true">Store</asp:listitem>
              <asp:listitem>Dept</asp:listitem>
              <asp:listitem>Notes</asp:listitem>
            </asp:dropdownlist>
          </td>
          <td colspan="2">
            &nbsp;
          </td>
        </tr>
        <tr>
          <td>
            Then by:
              <asp:dropdownlist ID="SortList2"
                runat="server" CssClass="ddl">
                <asp:listitem>Item</asp:listitem>
                <asp:listitem>QTY</asp:listitem>
                <asp:listitem>Store</asp:listitem>
                <asp:listitem Selected="true">Dept</asp:listitem>
                <asp:listitem>Notes</asp:listitem>
              </asp:dropdownlist>
          </td>
          <td>

          </td>
        </tr>
      </table>

      <asp:button id="SortButton"
        text="Sort"
        onclick="SortButton_Click" 
        runat="Server"/>  
            <br />
            <br />
            </div>


        <br />



        <button class="accordion" type="button">Frequent Items</button>
        <div id="frequentitems" class="panel">
            
            <asp:label runat="server" ID="labelfreqitems"/>
            <b id="freqitemsTitle">Frequent Items</b>
            <br />
            <br />
             <asp:GridView
                id="freqitems"
                DataSourceID="freq_items_source"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle BackColor="SaddleBrown" />
                <HeaderStyle CssClass="Headertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>     
             </Columns>
            </asp:GridView>
            <asp:SqlDataSource
                id="freq_items_source"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, description as Notes, CONVERT(VARCHAR(12), last_purchase_date, 107) 'Last Purchased' from freq_item where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br \ />
            <div>
            <asp:Button ID="freqRemove" Text="Remove" OnClick="freqItemsRemove" runat="server" />
            <asp:Button ID="freqUpdate" Text="Update" OnClick="freqItemsUpdate" runat="server" />
            </div>
            <br \ />
            <div id ="freqitemsalign">
            <asp:TextBox runat="server" ID="addfreq" placeholder="Frequent Item" CssClass="Textbox" />
            <asp:TextBox runat="server" ID="freqDesc" placeholder="Notes" CssClass="TextboxLong2" />
            <asp:ImageButton ID="freqplus" ImageUrl="Images/add.png" OnClick="freqaddBtn_Click" runat="server" />
            <br \ />
            </div>
            <div id ="align_adjust">
            <asp:Button runat="server" ID="addfromlist" OnClick="show_list" Text="Add from Recent Items" />
            </div>
            <br \ />
            <br \ />

        </div>
        <br/>
        <button class="accordion" type="button">List</button>
        <div id="list_items" class="panel">
            <asp:label runat="server" ID="labellistitems"/>
            <b id="itemsTitle">My Shopping List</b>
            <br />
            <br />
            <asp:GridView
                id="grdItems"
                DataSourceID="regitems"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle BackColor="SaddleBrown" />
                <HeaderStyle CssClass="Headertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
             </Columns>
               
            </asp:GridView>
            
            <asp:Button runat="server" ID="gotit" OnClick="removeBtn_Click" Text="Got It!" />
            <br /><br />
            <asp:SqlDataSource
                id="regitems"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, qty as QTY, store as Store, dept AS Dept, description as Notes from list_items where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        
            <div id="add">
                <asp:TextBox runat="server" ID="item" placeholder="Item"  CssClass="Textbox" />
                <asp:TextBox runat="server" ID="qty" placeholder="Quantity" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="store" placeholder="Store" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="dept" placeholder="Department" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="notes" placeholder="Notes" CssClass="TextboxLong" />
                <asp:ImageButton ID="addBtn" ImageUrl="Images/add.png" OnClick="addBtn_Click" runat="server" />
            </div>
            </div>

        </div>
        <br />
        <br />
        <div id="options">
            <a href="storeLocator.html" style="text-decoration: none; font-family: Lucida Sans Unicode Lucida Grande, sans-serif;" >Store Locator</a>
            <br />
            <asp:LinkButton runat="server" ID="signoutButton" Text="Sign Out" PostBackURL="Login.aspx" />
        </div>
            
    </form>

    <form id="freqitemsform" visible="false" runat="server">
        <div id="recentitemsbody">

           <asp:label runat="server" ID="labelrecent"/>
            <b id="recentitemsTitle">Add to Frequent Items:</b>
            <br />
            <br />
        <asp:GridView
                id="recentitems"
                DataSourceID="recent_items_source"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle BackColor="SaddleBrown" />
                <HeaderStyle CssClass="Headertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>     
             </Columns>
            </asp:GridView>
            <asp:SqlDataSource
                id="recent_items_source"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, description as Notes, CONVERT(VARCHAR(12), purchased, 107) 'Purchased On' from recent_items where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
           <asp:Button runat="server"  ID="recentcancel" OnClick="recentcancel_Click" Text="Cancel" />
           <asp:Button runat="server" ID="recentadd" OnClick="recentadd_Click" Text="Add" />
           </div>  
        <br \ />
        <br\ />


    </form>

    <script>
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    panel.style.display = "block";
                }
            });
        }
</script>
</body>
</html>
