
// trigger a compilation error if env[:variable] is not equal to 123
char c[<%= env[:variable] %> == 123 ? 10 : 0];

int main() { }
