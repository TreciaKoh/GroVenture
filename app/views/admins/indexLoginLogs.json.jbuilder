json.array!(@loginlogs) do |l|
json.extract! l, :userid, :logintime
end