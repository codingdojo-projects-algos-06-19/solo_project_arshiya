
$('#myForm').on('submit', function(e){
    $('#myModal').modal('show');
    e.preventDefault();
});
// $("#buttn1").click(function(){
//     var name = $('#name').val();
//     var alias = $('#alias').val();
//     var email = $('#email').val();
//     var pass = $('#pwd').val();
//     var cpass = $('#cpwd').val();

//     is_valid = True
//     if(name.length < 1) {
//         is_valid = False
//         alert("Please enter your name")
//     }
//     if(alias.length < 1) {
//     	is_valid = False
//         alert("Please enter a nick name")
//     }
//     if(pass != cpass) {
//         is_valid = False
//         alert("Passwords do not match!")
//     }
    
//     if(is_valid) {
        
//         $.ajax({
//             url: '/process',
//             type: 'POST',
//             async: false,
//             cache: 'false',
//             data: {
//                 'name' : name,
//                 'alias' : alias,
//                 'email' : email,
//                 'pass' : pass,
//             },
//             success: function(data, status) {
//                 $('#name').val('');  
//                 $('#alias').val(''); 
//                 $('#email').val('');
//                 $('#pwd').val('');
//                 alert(data);
//             }
//         });
//     }
    
// });

