String validateEmail(String text) =>
    (RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
            .hasMatch(text))
        ? null
        : " Email non valida.";
