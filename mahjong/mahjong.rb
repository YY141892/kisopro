$hai = {1=>"🀇 ",2=>"🀈 ",3=>"🀉 ",4=>"🀊 ",5=>"🀋 ",6=>"🀌 ",7=>"🀍 ",8=>"🀎 ",9=>"🀏 ",11=>"🀙 ",12=>"🀚 ",13=>"🀛 ",14=>"🀜 ",15=>"🀝 ",16=>"🀞 ",17=>"🀟 ",18=>"🀠 ",19=>"🀡 ",21=>"🀐 ",22=>"🀑 ",23=>"🀒 ",24=>"🀓 ",25=>"🀔 ",26=>"🀕 ",27=>"🀖 ",28=>"🀗 ",29=>"🀘 ",31=>"🀀 ",41=>"🀁 ",51=>"🀂 ",61=>"🀃 ",71=>"🀆 ",81=>"🀅 ",91=>"🀫 "}
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
    info = "東"+(kyoku+1).to_s+"局 "+honba.to_s+"本場 親:"+$oya.to_s+" ドラ:"+$hai[$yama[$yama.length-5]]+"\n"
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
    printf("流局\n\n")
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
    printf("手牌> "+tmp1.join+"  "+$hai[tumo]+"\n"+"      "+tmp2.join+"  "+k.to_s+"\n"+"切る牌を入力> ")
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
    printf("河"+num.to_s+" > "+tmp.join+"\n")
end

def inputcheck(input,min,max)
    if input>=min && input<=max 
        return input
    else
        printf("正しい形式で入力してください> ")
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