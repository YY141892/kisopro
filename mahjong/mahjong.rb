$hai = {1=>"ð ",2=>"ð ",3=>"ð ",4=>"ð ",5=>"ð ",6=>"ð ",7=>"ð ",8=>"ð ",9=>"ð ",11=>"ð ",12=>"ð ",13=>"ð ",14=>"ð ",15=>"ð ",16=>"ð ",17=>"ð ",18=>"ð  ",19=>"ðĄ ",21=>"ð ",22=>"ð ",23=>"ð ",24=>"ð ",25=>"ð ",26=>"ð ",27=>"ð ",28=>"ð ",29=>"ð ",31=>"ð ",41=>"ð ",51=>"ð ",61=>"ð ",71=>"ð ",81=>"ð ",91=>"ðŦ "}
$yama = Array.new()
$player = Array.new(Array.new())
$kawa = [[],[],[],[]]
$hainum = 3+3+3+3+1
$oya = 0

def sipi
    $hai.keys.each do |i|
        4.times do
            $yama<<i
        end
    end
    $yama.shuffle!
end

def hipi
    4.times do |i|
        tmp = Array.new()
        $hainum.times do |j|
            tmp << $yama[0]
            $yama.delete_at(0)
        end
        $player[i%4] = tmp.sort()
    end
end

def game(kyoku,honba)
    sipi()
    hipi()
    $kawa = [[],[],[],[]]
    info = "æą"+(kyoku+1).to_s+"åą "+honba.to_s+"æŽå ī čĶŠ:"+$oya.to_s+" ããĐ:"+$hai[$yama[$yama.length-5]]+"\n"
    printf(info)
    num = 0
    while $yama.length > 14 do
        playernum = ($oya+num)%4
        tumo = $yama[0]
        $yama.delete_at(0)
        if playernum == 0
            jitya(tumo)
        else
            tatya(tumo,playernum)
        end
        num += 1
    end
    printf("æĩåą\n\n")
end

def jitya(tumo)
    tehai = $player[0]
    tmp1 = Array.new()
    tmp2 = Array.new()
    k = 0
    tehai.each do |i|
        tmp1 << $hai[i]
        if k <10
            tmp2 << " "+k.to_s
        else
            tmp2 << k.to_s
        end
        k += 1
    end
    printf("æį> "+tmp1.join+"  "+$hai[tumo]+"\n"+"      "+tmp2.join+"  "+k.to_s+"\n"+"åãįãåĨå> ")
    k = inputcheck(gets.to_i,0,$hainum)
    tehai = tehai << tumo
    $kawa[0] << tehai[k]
    sute(0)
    tehai.delete_at(k)
    $player[0] = tehai.sort
end

def tatya(tumo,num)
    $kawa[num] << tumo
    sute(num)
    return
end

def sute(num)
    tmp = Array.new()
    $kawa[num].each do |i|
        tmp << $hai[i]
    end
    printf("æēģ"+num.to_s+" > "+tmp.join+"\n")
end

def inputcheck(input,min,max)
    if input>=min && input<=max 
        return input
    else
        printf("æ­Ģããå―Ēåžã§åĨåããĶãã ãã> ")
        return inputcheck(gets.to_i,min,max)
    end
end

def play
    $oya = rand(0..4)
    4.times do |i|
        $oya = ($oya+1)%4
        honba = 0
        while true do
            rentyan = game(i,honba)
            if !rentyan then
                break
            end
            honba += 1
        end
    end
    return
end