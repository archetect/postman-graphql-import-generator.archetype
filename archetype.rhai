let context = #{};

// This generally comes from ANSWERS, but prompting for it ensures it is in the context 
context += prompt("Project Author:", "author_full", #{
    placeholder: "Your Name <your.name@example.com>",
});

context += prompt("Project Prefix:", "project-prefix", #{
    default_value: "",
    cases: CasedIdentityCasedValue(PROGRAMMING_CASES),
});

context += prompt("Project Suffix:", "project-suffix", #{
    defaults_with: "Service",
    cases: CasedIdentityCasedValue(PROGRAMMING_CASES),
});

context += set("project-name", render("{{ project-prefix }}-{{project-suffix}}", context), #{
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
        FixedKeyCasedValue("project-title", KebabCase),
    ],
});

context += render(Archetype("model-casing"), ANSWERS + #{
});

render(Directory("contents"), context)
