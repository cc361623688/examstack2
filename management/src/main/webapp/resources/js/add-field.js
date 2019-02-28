$(function() {
	add_field.initial();
});

var add_field = {

	initial : function initial() {
		this.bindSubmitForm();
	},

	bindSubmitForm : function bindSubmitForm() {
		var form = $("form#field-add-form");

		$("#add-field-btn").click(function() {
			var result = add_field.verifyInput();
			if (result) {
				var data = new Object();
				data.fieldName = $("#name").val();
				data.memo = $("#memo").val();
				jQuery.ajax({
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					type : "POST",
					url : form.attr("action"),
					data : JSON.stringify(data),
					success : function(message, tst, jqXHR) {
						if (message.result == "success") {
							document.location.href = document
									.getElementsByTagName('base')[0].href
									+ util.getCurrentRole() + "/common/field-list";
						} else {
							alert(message.result);
						}
					}
				});
			}

			return false;
		});
	},

	verifyInput : function verifyInput() {
		$(".form-message").empty();
		var result = true;
		var check_n = this.checkName();
		// var check_e = this.checkEmail();
		var check_m = this.checkMemo();
		
		result = check_n && check_m;
		return result;
	},

	checkName : function checkName() {
		var f_name = $(".form-field-name input").val();
		if (f_name == "") {
			$(".form-field-name .form-message").text("题库名不能为空");
			return false;
		} else if (f_name.length > 40 || f_name.length < 3) {
			$(".form-field-name .form-message").text("请保持在3-40个字符以内");
			return false;
		} 
		return true;
	},
	
	checkMemo : function checkMemo() {
		var memo = $(".form-field-desc input").val();
		if (memo == "") {
			$(".form-field-desc .form-message").text("描述不能为空");
			return false;
		} else if (memo.length > 40 || memo.length < 3) {
			$(".form-field-desc .form-message").text("请保持在3-40个字符以内");
			return false;
		} 
		return true;
	}

};