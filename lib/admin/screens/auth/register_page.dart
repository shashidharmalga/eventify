import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isLoading =false;
  Future<void>_registerUser() async{
    final username = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmController.text.trim();

    if(username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      showErrorDialog("Please fill all the fields");
      return; 
    }
    if(password !=confirmPassword){
      showErrorDialog("Password and confirm password do not match");
      return;
    }
    setState(() {
      isLoading=true;
    });
    try{
      final authres = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final userId = authres.user?.id;

      if (userId != null) {
        await Supabase.instance.client.from('profile').insert({
          'id': userId,
          'username': username,
          'email': email,
          'year': selectedYear,
          'role': selectedRole,
        });
      }

      showDialog(context: context, builder:  (_)=>AlertDialog(
        title: Text("Registration Successful"),
        content: Text("Your account has been created successfully!, pleasse check your email for verification."),
        actions: [
          TextButton(onPressed: (){
            context.go('/login');
          }, child: Text("Ok"),)
        ],
      )); 
    }
    catch(e){
      print("Error: $e");
      showErrorDialog("Something went Wrong");
    }
    finally{
      setState(() {
        isLoading=false;
      });
    }
  }
  String selectedYear = '1st Year';
  List<String> year = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  String selectedRole = 'Student';
  List<String> roles = ['Student', 'Admin'];

  showErrorDialog(String message){
    showDialog(context: context, builder: (_)=>AlertDialog(
      title: Text(message),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Ok"))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:  [Colors.blue,Colors.purple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
            )
          ),
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 35),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                    ), 
                    child: Icon(
                      Icons.event_available_outlined,
                      color: Colors.blue,  
                      size: 32,
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Text("Join Eventify 🎉",style:GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 1.5)),
                SizedBox(height: 10,),
                Text("Create your student account",style: GoogleFonts.roboto(color: Colors.grey[200],fontSize: 14,)),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40))
                  ),
                  child: Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Full Name")
                        ),
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration( 
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey)
                          ),   
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.grey[500],
                          hintText: "Enter Your Full Name",
                          hintStyle: TextStyle(color: Colors.grey[400]),  
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey)
                          )
                        ),
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Email")
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration( 
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey)
                          ),   
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.grey[500],
                          hintText: "Enter Your Email",
                          hintStyle: TextStyle(color: Colors.grey[400]),  
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey)
                          )
                        ),
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Password")
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration( 
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey)
                          ),   
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Colors.grey[500],
                          hintText: "Enter Your Password",
                          hintStyle: TextStyle(color: Colors.grey[400]),  
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey)
                          )
                        ),
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Confirm Password")
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: confirmController,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey)
                          ),    
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Colors.grey[400],
                          hintText: "Confirm Your Password",
                          hintStyle: TextStyle(color: Colors.grey[400]),  
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey)
                          )
                        ),
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Year of Study")
                      ),
                      SizedBox(height: 8,),
                      DropdownButtonFormField<String>(
                        value: selectedYear,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 241, 239, 239),
                          prefixIcon: Icon(Icons.school),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                        ),
                        items: year.map((String years) {
                          return DropdownMenuItem<String>(
                            value: years,
                            child: Text(years),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Role")
                      ),
                      SizedBox(height: 8,),
                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          prefixIcon: Icon(Icons.assignment_ind_outlined),
                          labelText: 'Select Role',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey )
                          ),
                        ),
                        items: roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRole = newValue!;
                            
                          });
                        }
                      ),
                      SizedBox(height: 17,),
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: isLoading? null : _registerUser,
                          
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:isLoading?CircularProgressIndicator(color: Colors.white,): Text("Create Account",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(onPressed: (){
                            context.go('/login');                            
                          }, child: Text("Login here",style: TextStyle(color: Colors.blue)))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}