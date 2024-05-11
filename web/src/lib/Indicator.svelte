<script>
    export let timer = '00:00';
    export let fare = 0;
    export let seconds = '00';
    import { Separator } from "$lib/components/ui/separator";
    import { fade } from 'svelte/transition';
</script>

<main>
    <div transition:fade={{duration:250}} class="indicator-container">
        <div class="timer-container">
            <span>Timer</span>
            <span class="timer">{timer} <span>{seconds}</span></span>
        </div>
        <Separator orientation="vertical" class="opacity-75 h-14"/>
        <div class="fare-container">
            <span>Fare</span>
            <span class="text-green-500">${fare}</span>
        </div>
    </div>
</main>

<style>
    main{
        position: absolute;
        right: 0;
        top: 0;
        height: 100vh;
        width: 50vw;
        display: flex;
        align-items: center;
        justify-content: flex-end;
    }
    .indicator-container{
        position: relative;
        top: 10%;
        display: flex;
        flex-flow: row;
        align-items: center;
        background: linear-gradient(180deg, #3C57A1 -59.55%, #16203B 100%);
        min-width: 300px;
        min-height: 100px;
        width: auto;
        height: 10%;
        padding: 1rem 1.5rem 1rem 1.5rem;
        border-radius: 0.5rem;
        margin-right: 0.5rem;
        gap: 0.5rem;
    }
    .timer{
        display: flex;
    }
    .timer span{
        position: relative;
        top: 30%;
        left: 2%;
    }
    .timer-container, .fare-container{
        display: flex;
        flex-flow: column;
        font-family: Inter;
        color: white;
        flex-basis: 50%;
        height: 100%;
        align-items: flex-start;
        justify-content: center;
        font-weight: bold;
        line-height: 120%;
        gap: 0.25rem;
    }
    .timer-container{
        flex-grow: 0;
        flex-shrink: 1;
    }
    .fare-container{
        flex-grow: 1;
        align-items: flex-end;
    }
    .timer-container span:nth-child(1), .fare-container span:nth-child(1){
        font-weight: 600;
        opacity: 0.75;
        font-size: 0.8rem;
    }
    .timer-container span:nth-child(2), .fare-container span:nth-child(2){
        font-size: 2rem;
    }

    @media (max-width: 1024px){
        .indicator-container{
            min-height: 15%;
            min-width: 50%;
        }
        .timer-container, .fare-container{
            gap: 0;
        }
        .timer-container span:nth-child(1), .fare-container span:nth-child(1){
            font-size: 0.5rem;
        }
        .timer-container span:nth-child(2), .fare-container span:nth-child(2){
            font-size: 1rem;
        }
        .timer span{
            position: relative;
            top: 20%;
            left: 2%;
        }
    }
</style>