from django import forms

class ContactForm(forms.Form):
    company = forms.CharField(required=True,
                              widget=forms.TextInput(attrs={'class': 'form-control',
                                                            'placeholder': '会社名'}))

    division = forms.CharField(required=True,
                               widget=forms.TextInput(attrs={'class': 'form-control',
                                                             'placeholder': '部署名'}))

    name = forms.CharField(required=True,
                           widget=forms.TextInput(attrs={'class': 'form-control',
                                                         'placeholder': '氏名'}))

    address = forms.CharField(required=True,
                              widget=forms.TextInput(attrs={'class': 'form-control',
                                                            'placeholder': '住所'}))

    phone_number = forms.CharField(required=True,
                                   widget=forms.TextInput(attrs={'class': 'form-control',
                                                                 'placeholder': '電話番号'}))

    email = forms.EmailField(required=True,
                             widget=forms.TextInput(attrs={'class': 'form-control',
                                                           'placeholder': 'メールアドレス'}))

    content = forms.CharField(
        required=True,
        widget=forms.Textarea(attrs={'class': 'form-control',
                                     'placeholder': 'お問合せ内容'})
    )
