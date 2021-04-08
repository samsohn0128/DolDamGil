package com.spidycoder.doldamgilserver;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.net.URI;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/gyms")
@AllArgsConstructor(onConstructor_ = @Autowired)
public class GymController {
    private final ClientHttpRequestFactory clientHttpRequestFactory;

    private final GymRepository gymRepository;
    private final EdgeRepository edgeRepository;
    private final WallRepository wallRepository;
    private final RouteRepository routeRepository;
    private final RecordRepository recordRepository;

//    private final Map<String, String> edgeUris;
    private final Map<String, RecordPreparation> edgeToRecordPreparationMap;


    @GetMapping
    public List<Gym> retrieveAllGymsByParams(
            @RequestParam(defaultValue = "") String name,
            @RequestParam(defaultValue = "") String address
    ) {
        var gyms = gymRepository.findAllByNameContainingAndAddressContaining(name, address);
        return gyms;
    }


    @GetMapping("/{id}")
    public Gym retrieveGymById(@PathVariable Long id) {
        var gym = gymRepository.findById(id)
                .orElseThrow(GymNotFoundException::new);
        return gym;
    }


    @GetMapping("/{gymId}/edges")
    public List<Edge> retrieveAllEdges(@PathVariable Long gymId) {
        var edges = retrieveGymById(gymId).getEdges();
        return edges;
    }


    @GetMapping("/{gymId}/edges/{code}")
    public Edge retrieveEdgeByCode(
            @PathVariable Long gymId, @PathVariable Long code
    ) {
        var gym = retrieveGymById(gymId);
        var edge = edgeRepository.findById(new Edge.PK(gym, code))
                .orElseThrow(EdgeNotFoundException::new);
        return edge;
    }


    @PatchMapping("/{gymId}/edges/{code}")
    public RecordPreparation registerEdgeByCode(
            @PathVariable Long gymId, @PathVariable Long code, HttpServletRequest request
    ) {
        var addrPort = request.getRemoteHost() + ":" + request.getRemotePort();
        System.out.println("===============" + addrPort);
//        edgeUris.put("" + gymId + ":" + code, "localhost:" + request.getRemotePort());
//        edgeUris.put("" + gymId + ":" + code, addrPort);
        return edgeToRecordPreparationMap.get("" + gymId + ":" + code);
    }


    @GetMapping("/{gymId}/edges/{edgeCode}/walls")
    public List<Wall> retrieveAllWalls(
            @PathVariable Long gymId, @PathVariable Long edgeCode
    ) {
        var walls = retrieveEdgeByCode(gymId, edgeCode).getWalls();
        return walls;
    }


    @PostMapping("/{gymId}/edges/{edgeCode}/walls")
    @ResponseStatus(HttpStatus.CREATED)
    public Wall createWall(@PathVariable Long gymId, @PathVariable Long edgeCode) {
        var wall = new Wall();
        wall.setGymId(gymId);
        wall.setEdgeCode(edgeCode);
        return wallRepository.save(wall);
    }


    @GetMapping("/{gymId}/edges/{edgeCode}/walls/{creationTime}")
    public Wall retrieveWallByCreationTime(
            @PathVariable Long gymId,
            @PathVariable Long edgeCode,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime creationTime
    ) {
        var wall = wallRepository.findById(new Wall.PK(gymId, edgeCode, creationTime))
                .orElseThrow(WallNotFoundException::new);
        return wall;
    }


    @GetMapping("/{gymId}/edges/{edgeCode}/walls/{wallCreationTime}/routes")
    public List<Route> retrieveAllRoutes(
            @PathVariable Long gymId,
            @PathVariable Long edgeCode,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime wallCreationTime
    ) {
        var routes = retrieveWallByCreationTime(gymId, edgeCode, wallCreationTime).getRoutes();
        return routes;
    }


    @PostMapping("/{gymId}/edges/{edgeCode}/walls/{wallCreationTime}/routes")
    @ResponseStatus(HttpStatus.CREATED)
    public Route createRoute(
            @PathVariable Long gymId,
            @PathVariable Long edgeCode,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime wallCreationTime,
            @RequestHeader(name = "Doldamgil-Route-Creator-Id") Long creatorId,
            @RequestHeader(name = "Doldamgil-Route-Title", required = false) String title,
            @RequestHeader(name = "Doldamgil-Route-Difficulty", required = false) String difficulty
    ) {
        var route = new Route();
        route.setGymId(gymId);
        route.setEdgeCode(edgeCode);
        route.setWallCreationTime(wallCreationTime);
        route.setCreatorId(creatorId);
        route.setTitle(title);
        route.setDifficulty(difficulty);
        return routeRepository.save(route);
    }


    @GetMapping("/{gymId}/edges/{edgeCode}/walls/{wallCreationTime}/routes/{creatorId}/{creationTime}")
    public Route retrieveRouteByCreatorIdAndCreationTime(
            @PathVariable Long gymId,
            @PathVariable Long edgeCode,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime wallCreationTime,
            @PathVariable Long creatorId,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime creationTime
    ) {
        var routePk = new Route.PK(gymId, edgeCode, wallCreationTime, creatorId, creationTime);
        var route = routeRepository.findById(routePk)
                .orElseThrow(RouteNotFoundException::new);
        return route;
    }


    @GetMapping("/{gymId}/edges/{edgeCode}/walls/{wallCreationTime}/routes/{creatorId}/{creationTime}/records")
    public List<Record> retrieveAllRecords(
            @PathVariable Long gymId,
            @PathVariable Long edgeCode,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime wallCreationTime,
            @PathVariable Long creatorId,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime creationTime
    ) {
        var records = retrieveRouteByCreatorIdAndCreationTime(
                gymId, edgeCode, wallCreationTime, creatorId, creationTime
        ).getRecords();
        return records;
    }


    @PostMapping("/{gymId}/edges/{edgeCode}/walls/{wallCreationTime}/routes/{creatorId}/{creationTime}/records")
    @ResponseStatus(HttpStatus.CREATED)
    public Record createRecord(
            @PathVariable Long gymId,
            @PathVariable Long edgeCode,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime wallCreationTime,
            @PathVariable Long creatorId,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime creationTime,
            @RequestHeader(name = "Doldamgil-Record-Climber-Id") Long climberId,
            @RequestHeader(name = "Doldamgil-Record-Result") Record.Result result,
            @RequestHeader(name = "Doldamgil-Record-Difficulty", required = false) Integer difficulty,
            @RequestHeader(name = "Doldamgil-Record-Satisfaction", required = false) Record.Satisfaction satisfaction
    ) {
        var record = new Record();
        var route = retrieveRouteByCreatorIdAndCreationTime(gymId, edgeCode, wallCreationTime, creatorId, creationTime);
        record.setClimberId(climberId);
        record.setRoute(route);
        record.setResult(result);
        record.setDifficulty(difficulty);
        record.setSatisfaction(satisfaction);
        return recordRepository.save(record);
    }


    @PatchMapping("/{gymId}/edges/{edgeCode}/walls/{wallCreationTime}/routes/{creatorId}/{creationTime}/records")
    public void prepareRecord(
            @PathVariable Long gymId,
            @PathVariable Long edgeCode,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime wallCreationTime,
            @PathVariable Long creatorId,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime creationTime,
            @RequestHeader(name = "Doldamgil-Record-Climber-Id") Long climberId,
            HttpServletRequest request
    ) {
//        var uri = URI.create("http://" + edgeUris.get("" + gymId + ":" + edgeCode) + "/doldamgil-edge");
//        System.out.println("==================" + uri);
        var recordPreparation = new RecordPreparation(
                gymId, edgeCode, wallCreationTime, creatorId, creationTime, climberId
        );
        edgeToRecordPreparationMap.put("" + gymId + ":" + edgeCode, recordPreparation);
//        var restTemplate = new RestTemplate(clientHttpRequestFactory);
//        var responseEntity = RequestEntity.patch(uri)
//                .contentType(MediaType.APPLICATION_JSON_UTF8)
//                .accept(MediaType.APPLICATION_JSON_UTF8)
//                .body(recordPreparation);
//        var result = restTemplate.exchange(uri, HttpMethod.PATCH, responseEntity, String.class);
//        return result;
    }
}
