<script type="text/x-kendo-template" id="gridToolbar">
<ul id="menuGrid" class="kendoGridMenu">
    <sec:access url="/secUser/update">
        <li onclick="editSecUser();"><i class="fa fa-edit"></i>Edit</li>
    </sec:access>
    <sec:access url="/secUser/delete">
        <li onclick="deleteUser();"><i class="fa fa-trash-o"></i>Delete</li>
    </sec:access>
</ul>
</script>

<script language="javascript">
    var gridSecUser, dataSource, secUserModel;

    $(document).ready(function () {
        onLoadSecUserPage();
        initSecUserGrid();
        initObservable();
    });

    function onLoadSecUserPage() {
        // initialize form with kendo validator & bind onSubmit event
        initializeForm($("#userForm"), onSubmitSecUser);
        // update page title
        $(document).attr('title', "Grails - Create User");
    }

    function executePreCondition() {
        if (!validateForm($("#userForm"))) {
            return false;
        }
        return true;
    }

    function onSubmitSecUser() {
        if (executePreCondition() == false) {
            return false;
        }

        setButtonDisabled($('#create'), true);
        showLoadingSpinner(true);
        var actionUrl = null;
        if ($('#id').val().isEmpty()) {
            actionUrl = "${createLink(controller:'secUser', action: 'create')}";
        } else {
            actionUrl = "${createLink(controller:'secUser', action: 'update')}";
        }

        jQuery.ajax({
            type: 'post',
            data: jQuery("#userForm").serialize(),
            url: actionUrl,
            success: function (data, textStatus) {
                executePostCondition(data);
                setButtonDisabled($('#create'), false);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                afterAjaxError(XMLHttpRequest, textStatus)
            },
            complete: function (XMLHttpRequest, textStatus) {
                showLoadingSpinner(false);
            },
            dataType: 'json'
        });
        return false;
    }

    function executePostCondition(result) {
        if (result.isError) {
            showError(result.message);
            showLoadingSpinner(false);
        } else {
            try {
                var newEntry = result.secUser;
                if ($('#id').val().isEmpty() && newEntry != null) { // newly created
                    var gridData = gridSecUser.dataSource.data();
                    gridData.unshift(newEntry);
                } else if (newEntry != null) { // updated existing
                    var selectedRow = gridSecUser.select();
                    var allItems = gridSecUser.items();
                    var selectedIndex = allItems.index(selectedRow);
                    gridSecUser.removeRow(selectedRow);
                    gridSecUser.dataSource.insert(selectedIndex, newEntry);
                }
                resetForm();
                showSuccess(result.message);
            } catch (e) {
                // Do Nothing
            }
        }
    }

    function resetForm() {
        clearForm($("#userForm"), $('#name'));
        initObservable();
        $('#create').html("<span class='k-icon k-i-plus'></span>Create");
    }

    function initDataSource() {
        dataSource = new kendo.data.DataSource({
            transport: {
                read: {
                    url: "${createLink(controller: 'secUser', action: 'list')}",
                    dataType: "json",
                    type: "post"
                }
            },
            schema: {
                type: 'json',
                data: "list", total: "count",
                model: {
                    fields: {
                        id: { type: "number" },
                        version: { type: "number" },
                        username: { type: "string" },
                        enabled: { type: "boolean" },
                        accountLocked: { type: "boolean" },
                        accountExpired: { type: "boolean" }
                    }
                },
                parse: function (data) {
                    checkIsErrorGridKendo(data);
                    return data;
                }
            },
            pageSize: 15,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true
        });
    }

    function initSecUserGrid() {
        initDataSource();
        $("#gridSecUser").kendoGrid({
            dataSource: dataSource,
            height: getGridHeightKendo(),
            selectable: true,
            sortable: true,
            resizable: true,
            reorderable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 15, 20],
                buttonCount: 4
            },
            columns: [
                {field: "username", title: "User Name", width: 200, sortable: false, filterable: {cell: {operator: "contains", dataSource:getBlankDataSource()}}},
                {field: "enabled", title: "Enabled", width: 30, sortable: false, filterable: false,attributes: {style: setAlignCenter()},
                    headerAttributes: {style: setAlignCenter()}, template:"#=enabled?'YES':'NO'#"},
                {field: "accountLocked", title: "Locked", width: 30, sortable: false, filterable: false,attributes: {style: setAlignCenter()},
                    headerAttributes: {style: setAlignCenter()}, template:"#=accountLocked?'YES':'NO'#"},
                {field: "accountExpired", title: "Expired", width: 30, sortable: false, filterable: false,attributes: {style: setAlignCenter()},
                    headerAttributes: {style: setAlignCenter()}, template:"#=accountExpired?'YES':'NO'#"}
            ],
            filterable: {
                mode: "row"
            },
            toolbar: kendo.template($("#gridToolbar").html())
        });
        gridSecUser = $("#gridSecUser").data("kendoGrid");
        $("#menuGrid").kendoMenu();
    }

    function initObservable() {
        secUserModel = kendo.observable(
                {
                    secUser: {
                        id: "",
                        version: "",
                        username: "",
                        enabled: false,
                        accountLocked: false,
                        accountExpired: false
                    }
                }
        );
        kendo.bind($("#application_top_panel"), secUserModel);
    }

    function deleteUser() {
        if (executePreConditionForDelete() == false) {
            return;
        }
        showLoadingSpinner(true);
        var secUserId = getSelectedIdFromGridKendo(gridSecUser);
        $.ajax({
            url: "${createLink(controller: 'secUser', action:  'delete')}?id=" + secUserId,
            success: executePostConditionForDelete,
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                afterAjaxError(XMLHttpRequest, textStatus)
            },
            complete: function (XMLHttpRequest, textStatus) {
                showLoadingSpinner(false);
            },
            dataType: 'json',
            type: 'post'
        });
    }

    function executePreConditionForDelete() {
        if (executeCommonPreConditionForSelectKendo(gridSecUser, 'user') == false) {
            return false;
        }
        if (!confirm('Are you sure you want to delete the selected User?')) {
            return false;
        }
        return true;
    }

    <%-- removing selected row and clean input form --%>
    function executePostConditionForDelete(data) {
        if (data.isError){
            showError(data.message);
            return false;
        }
        var row = gridSecUser.select();
        row.each(function () {
            gridSecUser.removeRow($(this));
        });
        resetForm();
        showSuccess(data.message);
    }

    function editSecUser() {
        if (executeCommonPreConditionForSelectKendo(gridSecUser, 'user') == false) {
            return;
        }
        var secUser = getSelectedObjectFromGridKendo(gridSecUser);
        showSecUser(secUser);
    }

    function showSecUser(secUser) {
        secUserModel.set('secUser', secUser);
        $('#create').html("<span class='k-icon k-i-plus'></span>Update");
    }

</script>
