<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PartsAndVendors.PVMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.min.js"></script>
    <script src="Scripts/jquery.validate.js"></script>
    <script type="text/javascript">
            $(document).ready(function () {
                $('#<%=txtSearchFor.ClientID%>').autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            url: "Default.aspx/fillText",
                            data: '{field : "' + $('#<%=drpSearchBy.ClientID%>').val() + '", search: "' + $('#<%=txtSearchFor.ClientID%>').val() + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (r) {
                                response(r.d);
                            },
                            error: function (result) {
                                alert("Fail");
                            }
                        });
                    }
                });
            });
        function displayControls() {
            $(document).ready(function () {
                var drpSearchBy = $('#<%=drpSearchBy.ClientID%> option:selected').text();
                var drpSearchFor = $('#<%=drpSearchFor.ClientID%>');
                var butSearch = $('#<%=butSearch.ClientID%>');
                var txtSearch = $('#<%=txtSearchFor.ClientID%>');

                if (drpSearchBy != '--Select Field--') {
                    butSearch.show();

                    txtSearch
                        .show()
                        .focus()
                        .select()
                        .val('');

                    drpSearchFor.hide();
                }
                else {
                    txtSearch.hide();
                    butSearch.hide();
                }
            });
        }
    </script>
    <div id="butBar">
        <div id="filterDiv">
            <asp:DropDownList ID="drpSearchBy" CssClass="searchDropDown searchDropDownSearchBy" onchange="displayControls()" runat="server" 
                AutoPostBack="false">
                <asp:ListItem>--Select Field--</asp:ListItem>
                <asp:ListItem>Cage Code</asp:ListItem>
                <asp:ListItem>COG</asp:ListItem>
                <asp:ListItem>FSC</asp:ListItem>
                <asp:ListItem>NIIN</asp:ListItem>
                <asp:ListItem>Parent Assembly</asp:ListItem>
                <asp:ListItem>Part Number</asp:ListItem>
                <asp:ListItem>Title</asp:ListItem>
                <asp:ListItem>Ref(t)</asp:ListItem>
            </asp:DropDownList>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
            <asp:DropDownList ID="drpSearchFor" CssClass="searchDropDown searchDropDownSearchFor" runat="server"></asp:DropDownList>
            <asp:TextBox ID="txtSearchFor" CssClass="txtSearchFor" runat="server"></asp:TextBox>
            <asp:Button ID="butSearch" CssClass="searchButton" runat="server" Text="Button" OnClick="butSearch_Click" />
        </div>
        <div id="butDiv">
            <asp:Button ID="butMaster" CssClass="menuButtons menuButtonMaster" runat="server" />
            <asp:Button ID="butParts" CssClass="menuButtons menuButtonsParts" runat="server" />
            <asp:Button ID="butVendors" CssClass="menuButtons menuButtonVendors" runat="server" />
        </div>
        <div id="viewDiv">
            <asp:MultiView ID="mvPV" runat="server" ActiveViewIndex="0">
                <asp:View ID="masterView" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div id="masterDiv">
                                <div id="grdViewDiv" style="height:400px; width:750px; overflow:auto; left:25px; top:65px;">
                                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Both" Height="400" Width="100%">
                                        <asp:GridView ID="grdMaster" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                            <Columns>
                                                <asp:BoundField DataField="PartNum" HeaderText="PartNum" SortExpression="PartNum" />
                                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                                <asp:BoundField DataField="ParentAssy" HeaderText="ParentAssy" SortExpression="ParentAssy" />
                                                <asp:BoundField DataField="CageCode" HeaderText="CageCode" SortExpression="CageCode" />
                                                <asp:BoundField DataField="FSC" HeaderText="FSC" SortExpression="FSC" />
                                                <asp:BoundField DataField="NIIN" HeaderText="NIIN" SortExpression="NIIN" />
                                                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
                                                <asp:BoundField DataField="UI" HeaderText="UI" SortExpression="UI" />
                                                <asp:BoundField DataField="CurCost" HeaderText="CurCost" SortExpression="CurCost" />
                                                <asp:BoundField DataField="Ref(t)" HeaderText="Ref(t)" SortExpression="Ref(t)" />
                                                <asp:BoundField DataField="UID" HeaderText="UID" SortExpression="UID" />
                                                <asp:BoundField DataField="SMR" HeaderText="SMR" SortExpression="SMR" />
                                                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <RowStyle ForeColor="#000066" Font-Size="Smaller" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                            <SortedDescendingHeaderStyle BackColor="#00547E" />
                                        </asp:GridView>
                                    </asp:Panel>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="butSearch" />
                        </Triggers>
                    </asp:UpdatePanel>
                </asp:View>
                <asp:View ID="partsView" runat="server"></asp:View>
                <asp:View ID="vendorView" runat="server"></asp:View>
            </asp:MultiView>
        </div>
    </div>
</asp:Content>
