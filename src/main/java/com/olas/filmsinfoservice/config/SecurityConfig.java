package com.olas.filmsinfoservice.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.ExceptionMappingAuthenticationFailureHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import com.olas.filmsinfoservice.user.ActiveUserStore;
import com.olas.filmsinfoservice.user.MyUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter
{
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private MyUserDetailsService myUserDetailsService;
	
	 @Autowired
	 public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception
	 {
		 auth.authenticationProvider( authProvider() );
	 }
	 
	 @Override
	 protected void configure(HttpSecurity http) throws Exception
	 {
		 http.authorizeRequests()
		 .antMatchers("/login**").anonymous()
		 .antMatchers("/rateMovie/{movieID}",
				 "/user/{username}/editAccount", 
				 "/user/{username}/editAccount/saveName", "/user/{username}/editAccount/saveAge" ,
				 "/user/{username}/editAccount/saveDescription",
				 "/user/{username}/editAccount/saveFavMovies",
				 "/user/{username}/editAccount/saveAboutUser",
				 "/user/{username}/notifications",
				 "/user/{username}/friendsActivity",
				 "/user/{username}/changePassword", "/user/{username}/changedPassword",
				 "/addMainComment", "/addReplyComment",
				 "/deleteMainAndReplyComments", "/deleteReplyComment", 
				 "/likeComment").authenticated()
		 .antMatchers(
				 "/movies/delete/{movieID}",
				 "/movies/update/{currentMovieID}", "/movies/updated/{currentMovieID}",
				 "/movies/add", "/movies/added",
				 "/people/delete/{personID}",
				 "/people/update/{currentPersonId}", "/people/updated/{currentPersonId}",
				 "/people/add", "/people/added", 
				 "/updateMovie", "/deleteMovie", "/updatePerson", "/deletePerson",
				 "/adminPanel").hasAnyRole("ADMIN","HOST")
		 .antMatchers(
				 "/hostPanel",
				 "/banUser" , "unbanUser", 
				 "/takeAdmin", "/giveAdmin",
				 "/takeHost", "/giveHost").hasRole("HOST")
		.and()
			.exceptionHandling().accessDeniedPage("/WEB-INF/views/accessDenied.jsp")
		.and()
			.formLogin().loginPage("/login")
			.defaultSuccessUrl("/home")
			.successHandler( myAuthenticationSuccessHandler() )
			//.failureUrl("/login?error")  
			.failureHandler( exceptionMappingAuthenticationFailureHandler() )
			.usernameParameter("username").passwordParameter("password")	
		.and()
			.logout().logoutSuccessHandler( myLogoutSuccessHandler() );
		 
	 }
	 
	 @Bean
	 public ActiveUserStore activeUserStore()
	 {
	     return new ActiveUserStore();
	 }
	 
	 @Bean
	 public DaoAuthenticationProvider authProvider() 
	 {
	     DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
	     authProvider.setUserDetailsService(myUserDetailsService);
	     authProvider.setPasswordEncoder(passwordEncoder);
	     return authProvider;
	 }
	 
	 @Bean
	 public AuthenticationSuccessHandler myAuthenticationSuccessHandler()
	 {
		 return new MySimpleUrlAuthenticationSuccessHandler();
	 }
	 
	 @Bean
	 public LogoutSuccessHandler myLogoutSuccessHandler()
	 {
		 return new MyLogoutSuccessHandler();
	 }
	 
	 @Bean
	 public ExceptionMappingAuthenticationFailureHandler exceptionMappingAuthenticationFailureHandler()
	 {
	     ExceptionMappingAuthenticationFailureHandler ex = new ExceptionMappingAuthenticationFailureHandler();
	     Map<String, String> mappings = new HashMap<String, String>();
	     mappings.put("org.springframework.security.authentication.LockedException", "/login?banned");
	     mappings.put("org.springframework.security.core.userdetails.UsernameNotFoundException", "/login?error");
	     mappings.put("org.springframework.security.authentication.BadCredentialsException", "/login?error");
	     mappings.put("org.springframework.security.authentication.CredentialsExpiredException", "/login?error");
	     mappings.put("org.springframework.security.authentication.DisabledException", "/login?verifyEmail");
	     ex.setExceptionMappings(mappings);
	     return ex;
	 }
}