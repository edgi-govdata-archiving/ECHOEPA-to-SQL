import jinja2
from django.template.loader import render_to_string
from django.conf import settings
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
settings.configure()
def sendMail(text,sender_email = "pstdenis@widow-tll.labs.stonybrook.edu",receiver_email = "pstdenis@gmail.com"):

	message = MIMEMultipart("alternative")
	message["Subject"] = "multipart test"
	message["From"] = sender_email
	message["To"] = receiver_email

	# Create the plain-text and HTML version of your message
	html = "<pre>%s</pre>" %text 

	# Turn these into plain/html MIMEText objects
	part1 = MIMEText(text, "plain")
	part2 = MIMEText(html, "html")

	# Add HTML/plain-text parts to MIMEMultipart message
	# The email client will try to render the last part first
	message.attach(part1)
	message.attach(part2)
	# Send the message via local SMTP server.
	s = smtplib.SMTP('localhost')
	# sendmail function takes 3 arguments: sender's address, recipient's address
	# and message to send - here it is sent as one string.
	try:
		s.sendmail( sender_email,receiver_email, message.as_string())
		s.set_debuglevel(1)
		print("sent")
	except SMTPException:
	   print ("Error: unable to send email")
	s.quit()
def render_temp(template_name, **template_vars):
    """
    Usage is the same as flask.render_template:

    render_without_request('my_template.html', var1='foo', var2='bar')
    """
    env = jinja2.Environment(
        loader=jinja2.PackageLoader('name.ofmy.package','templates')
    )
    template = env.get_template(template_name)
    return template.render(**template_vars)


if __name__ == '__main__':
    import db_connect
    engine,whichDb= db_connect.connect()
    sql=""
    data=engine.execute('select * from "%s"' %"Last-Modified").fetchall()
   
    #data = mycursor.fetchall() 
    html= render_to_string('./modified.html', data)
    sendMail(html)
 
