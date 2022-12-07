This file describes the source code of rhstring.

# Features
- [[#initialize]]
	- [[#initial by a const string]]
	- [[#initial by a non-const string]]
- [[#copy]]
- [[#append]]
- [[#get string]]
- [[#get length of string]]
- [[#compare operator]]
- [[#reassignement operator]]

# Source Code
**header**
```cpp
class String {
```
## initialize
### initial by a const string
using example like:
```cpp
String s("Hello");
String* s1 = new String("Hello");
```
**header**
```cpp
public:
	String(const char* init="");
```
**body**
```cpp
String::String(const char* init) {
	char* cP = __constCharToChar__(init);
	__initRawString__(cP);
	delete cP;
}
```
### initial by a non-const string
like:
```cpp
char c[255]="hello";
String s0(c);
```
**header**
```cpp
public:
	String(char* init);
```
**body**
```cpp
String::String(char* init) {
	__initRawString__(init);
}
```

## init string from char
**header**
```cpp
private:
	void __initRawString__(char* p);
```
**body**
```cpp
void String::__initRawString__(char* p) {
	__rawLength = __calculateLength__(p);
	__rawString = new char[__rawLength+1];
	int pos=0;
	while (pos < __rawLength) {
		*(__rawString+pos) = *(p+pos);
		pos++;
	}
	*(__rawString+pos) = '\0';
	return;
}
```
## copy
copy feature used to get string from a given argument to current already created class.
```cpp
String s("hpp");
String* s2P = new String("cpp");
s.copy(s2P);
s.copy((*s2P)());
```
As above examples, the argument of copy should support:
- pointer of current `String` class;
- `char*`;
- `const char*`;
*Copy when source/target length not match:*
The copy can auto fit the length of target string.
**header**
```cpp
public:
	void copy(String* strP);
	void copy(const char* strP);
	void copy(char* strP);
```
**body**
```cpp
void String::copy(String* strP) {
	int tlen = strP->len();
	if (tlen != __rawLength) __updateLength__(tlen);
	__copyFromChar__((*strP)());
}
void String::copy(const char* strP) {
	char* cP = __constCharToChar__(strP);
	__copyFromChar__(cP);
	delete cP;
	return;
}
void String::copy(char* strP) {
	__copyFromChar__(strP);
	return;
}
```
*relatives*
- [[#updateLength]]
- [[#calculateLength]]
- [[#copyFromChar]]
- [[#constCharToChar]]

## constCharToChar
An internal function to return a `char*` from the given `const char*`.
**header**
```cpp
private:
	char* __constCharToChar__(const char* srcP);
```
**body**
```cpp
char* String::__constCharToChar__(const char* srcP) {
	int tlen = __calculateLength__(srcP);
	char* cP = new char[tlen+1];
	*(cP+tlen) = '\0'; // add a stop char at tail of string
	int pos=0;
	while (pos < tlen) {
		*(cP+pos)=*(srcP+pos);
		pos++;
	}
	return cP;
}
```
*relatives*
- [[#calculateLength]], shall support `const char*`
- 
## copyFromChar
**header**
```cpp
private:
	void __copyFromChar__(char* srcP);
```
**body**
```cpp
void String::__copyFromChar__(char* srcP) {
	int tlen = __calculateLength__(srcP);
	if (__rawLength!=tlen) __updateLength__(tlen);
	int pos=0;
	while (pos < __rawLength) {
		*(__rawString+pos) = *(srcP+pos);
		pos++;
	}
	return;
}
```
## calculateLength
This function is internal function, to calculate thel ength of given `char*`.
**header**
```cpp
private:
	int __calculateLength__(char* srcP);
	int __calculateLength__(const char* srcP);
```
**body**
```cpp
int String::__calculateLength__(char* srcP) {
	int pos=0;
	while (*(srcP+pos)!='\0') {pos++;}
	return pos;
}
int String::__calculateLength__(const char* srcP) {
	int pos=0;
	while (*(srcP+pos)!='\0') {pos++;}
	return pos;
}
```
## updateLength
This is an internal function to update the `__rawLength` to the specified argument value. And renew the `__rawString` pointer according to the specified length;
**header**
```cpp
private:
	void __updateLength__(int v,bool keep=false);
```
**body**
```cpp
void String::__updateLength__(int v,bool keep) {
	__rawLength = v;
	__renew__(keep);
}
```
*relatives*
- [[#renew]]
## renew
this internal function be invoked while this class is already created but want to renew the `__rawString` pointer to a newly assigned length
**header**
```cpp
private:
	// currently not support keep original string, if later required,
	// then this function can be updated later.
	void __renew__(bool keep=false);
```
**body**
```cpp
void String::__renew__(bool keep) {
	char* original = __rawString;

	__rawString = new char[__rawLength+1];
	int pos=0;
	// init program, can be a standalone function
	while (pos <= __rawLength) {
		*(__rawString+pos) = '\0';pos++;
	}
	if (keep) {
		pos = 0;
		int len = __calculateLength__(original);
		while (pos < len) {
			*(__rawString+pos) = *(original+pos);
			pos++;
		}
	}
	delete original;
	return;
}
```
## append
#TBD 
To append the string directly by given `char*` or `const char*`
**header**
```cpp
public:
	void append(const char* srcP);
	void append(char* srcP);
```
**body**
```cpp
void String::append(char* srcP) {
	int tlen = __calculateLength__(srcP);
	int originalLen = __rawLength;
	__updateLength__(originalLen+tlen,true);
	int pos=0;
	while (pos < tlen) {
		*(__rawString+originalLen+pos) = *(srcP+pos);
		pos++;
	}
	return;
}
void String::append(const char* srcP) {
	char* cP = __constCharToChar__(srcP);
	append(cP);
	delete cP;
	return;
}
```
## internal fields
The `__rawString` is a point of chars that stores the real string of current class

**header**
```cpp
private:
	char* __rawString;
	int   __rawLength;
```


## get length of string
This is a public API to get current string's length stored in this class.
**header**
```cpp
public:
	int len();
```
**body**
```cpp
int String::len() {
	return __rawLength;
}
```

## get string
currently supports one way to get string, by the operator `()`
**header**
```cpp
public:
	char* operator () ();
```
**body**
```cpp
char* String::operator() () {
	return __rawString;
}
```

## compare operator
**header**
```cpp
public:
	// return true if not equal
	bool operator != (const char* rhs);
	// return true if equal
	bool operator == (const char* rhs);
```
**body**
```cpp
bool String::operator == (const char* rhs) {
	int rhslen = __calculateLength__(rhs);
	if (__rawLength!=rhslen) return false;
	int pos=0;
	while (pos < __rawLength) {
		if (*(__rawString+pos)!=*(rhs+pos)) {
			return false;
		}
		pos++;
	}
	return true;
}
bool String::operator != (const char* rhs) { 
	int rhslen = __calculateLength__(rhs);
	if (__rawLength!=rhslen) return true;
	int pos=0;
	while (pos < __rawLength) {
		if (*(__rawString+pos)!=*(rhs+pos)) {
			return true;
		}
		pos++;
	}
	return false;
}
```
## reassignement operator
The string can be reassigned by `=` operator like a typical assignment, current support:
- const char and char
**header**
```cpp
public:
	void operator = (const char* init);
	void operator = (char* init);
```
**body**
```cpp
void String::operator = (char* init) {
	__copyFromChar__(init);
}
void String::operator = (const char* init) {
	char* cP = __constCharToChar__(init);
	__copyFromChar__(cP);
	delete cP;
}
```