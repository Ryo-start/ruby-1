require "csv" # CSVファイルを扱うためのライブラリを読み込み

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

if memo_type == 1
    puts "新規メモを作成します。ファイル名を入力してください"
    file_name = gets.chomp # ファイル名を取得

    puts "メモの内容を入力してください。終了するには Ctrl + D を押してください。"
    memo_content = readlines.map(&:chomp) # メモの内容を複数行で取得

    CSV.open("#{file_name}.csv", "w") do |csv| #CSVに書き込みコード
    csv << memo_content #memo_contentをcsvに格納
    end
    puts "メモが保存されました。"

elsif memo_type == 2
    puts "編集するファイル名を入力してください。"
    file_name = gets.chomp 

    if File.exist?("#{file_name}.csv") #?＝true or falseの真偽値
        puts "現在のメモの内容は以下の通りです："
        CSV.foreach("#{file_name}.csv") do |row| #CSVから読み込みコード
          puts row.join(" ") #joinは配列間の埋め込み
        end

        puts "追加する内容を入力してください。終了するには Ctrl + D を押してください。"
        new_content = readlines.map(&:chomp) # 追記内容を取得

        CSV.open("#{file_name}.csv", "a") do |csv|
            csv << new_content
        end
        puts "メモが更新されました。"
    else
        puts "指定されたファイルは存在しません。"
    end
end    