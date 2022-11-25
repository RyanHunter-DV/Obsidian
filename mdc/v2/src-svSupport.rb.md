The `SVSupport` class is kind of a database, which derives from the `DataBase` and can process SV language MD files.

# initialize
When in initialization, the `FileProcessor` should be given by the caller, then the `SVSupport` can start initialize base information.
## setup mark processor
The tool uses `SVMarkPool` to collect all available mark information from the file processor, so in initialization of `SVSupport`, a new `SVMarkPool` will be created, which will first collect file contents into a dictionary. Like:
```ruby
@mp = SVMarkPool.new(@fp);
```
# processSource
provide `processSource` for the main thread to call, by calling of this API, it'll go through all available marks that collected by `SVMarkPool` at initialize of the `SVSupport`.

## process package typed mark
#TBD 
reference links:
- [[arch-supportSVPackage]]
- [[src-svPackage.rb]], #TODO

Once detect a package mark, create a new `SVPackage`, and pass through all the **import** and **include** mark to it. For now, one MD file can only contain one **package** mark, and all others should be **import** and **include**.

## process svclass typed mark
## process field typed mark
## process method typed mark
## process tlm typed mark
reference links:
- [[arch-SVClassFeatures#F-declareTLMs]]
- [[src-svTLM.rb]]