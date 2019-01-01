from django.shortcuts import render, redirect

def index(request):
    return render(request, 'pages/index.html')

def contact(request):
    from .forms import ContactForm
    from django.core.mail import EmailMessage
    from django.template import Context
    from django.template.loader import render_to_string

    form_class = ContactForm

    # new logic!
    if request.method == 'POST':
        form = form_class(data=request.POST)

        if form.is_valid():
            company = request.POST.get(
                'company'
                , '')
            division = request.POST.get(
                'division'
                , '')
            name = request.POST.get(
                'name'
                , '')
            address = request.POST.get(
                'address'
                , '')
            phone_number = request.POST.get(
                'phone_number'
                , '')
            email = request.POST.get(
                'email'
                , '')
            content = request.POST.get('content', '')

            # Email the profile with the
            # contact information
            context = {
                'company'      : company,
                'division'     : division,
                'name'         : name,
                'address'      : address,
                'phone_number' : phone_number,
                'email'        : email,
                'content'      : content,
            }
            content = render_to_string('pages/contact_template.txt', context)

            email = EmailMessage(
                subject = "[ToMoCA] Thank you for contacting us",
                body = content,
                to = ["ks6088ts@gmail.com", "take@tomoca.jp", email],
            )
            email.send()
            return redirect('/')
        else:
            error_message = '入力データが不正です。再度入力をお願いします。/ Input data is invalid. Please fill in correct data.'
            return render(request, 'pages/contact.html', {
                'error': error_message,
                'form': form_class,
            })

    return render(request, 'pages/contact.html', {
        'form': form_class,
    })
