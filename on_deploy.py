from mako.template import Template

# Compile the template
print("Compiling template: ", end="")
Template(filename="./template.mako", module_directory="./mako_modules")
print("DONE")
