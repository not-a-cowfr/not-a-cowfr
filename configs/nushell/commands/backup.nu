# create a new backup of a directory in ~/.backup
def "backup new" [
    path: path, # path of the directory to backup
    name?: string, # name override of the backup dir, by default it uses the dirname of what youre backing up
]: nothing -> nothing {
    let path = $path | path expand;

    let name: string  = ($name | default ($path | path basename));
    let backup_dir = $"~/.backup/($name)" | path expand;

    mkdir $backup_dir;
    let versions = (ls $backup_dir | where type == "dir" | get name | path basename)
    
    mut version = "v1";
    if ($versions | is-not-empty) {
        let version_num = (
            $versions
            | parse "v{num}"
            | get num
            | each { $in | into int }
            | math max
        ) + 1;
        
        $version = $"v($version_num)";
    }
    
    let version_dir = $"($backup_dir)/($version)/";

    mkdir $version_dir;
    for item in (ls $path | get name) {
        print $"Copying ($item)";
        cp -r $item $version_dir;
    }
}
